class Public::ReviewsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_correct_member,  only: [:edit, :update, :destroy]
  before_action :member_is_guest?, except: [:show, :index]
  rescue_from ActiveRecord::RecordNotFound, with: :public_review_handle_record_not_found

  def select_museums
    @museums = Museum.new
  end

  def select_exhibitions
    @exhibitions = Exhibition.new
    handle_museum_selection_session(session[:selected_museum_id])
  end

  def selected_museum
    handle_museum_selection(params[:museum][:museum_id])
  end

  def selected_exhibition
    handle_exhibition_selection(params[:exhibition][:exhibition_id])
  end

  def new
    @review = Review.new
    handle_exhibition_selection_session(session[:selected_exhibition_id])
  end

  def create
    @review = Review.new(review_params)
    @review.member_id = current_member.id
    @review.exhibition_id = params[:review][:exhibition_id]

    if @review.save
      # extract_tags_from_space_separated_string
      extract_tags_from_google_vision_api
      session.delete(:selected_exhibition_id)
      badge_condition_met(@review.member)
      set_flash_message("レビューの作成に成功しました")
      redirect_to review_path(@review)
    else
      set_flash_message("レビューの作成に失敗しました")
      handle_exhibition_selection_session(session[:selected_exhibition_id])
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    redirect_if_review_not_found(@review)
    @review_comments = @review.review_comments
                      .includes(:member)
                      .where(members: { is_active: true })
                      .order(created_at: :desc)
                      .page(params[:page])
    @review_comment = ReviewComment.new
  end

  def index
    @all_reviews = fetch_reviews
    following_member_ids = current_member.followings.pluck(:id)
    @following_member_reviews = fetch_reviews(following_member_ids)
  end


  def edit
    @tags = @review.tags
  end

  def update
    @original_review = Review.find(params[:id])

    if @review.update(review_params)
      # extract_tags_from_space_separated_string
      set_flash_message("レビュー情報の保存に成功しました")
      redirect_to review_path(@review)
    else
      copy_error_attributes_from_original_review
      set_flash_message("レビュー情報の保存に失敗しました")
      @tags = @review.tags
      render :edit
    end
  end

  def destroy
    if @review.destroy
      set_flash_message("レビューの削除に成功しました")
      redirect_to reviews_path
    else
      set_flash_message("レビューの削除に失敗しました")
      render :edit
    end
  end

  protected

  # 選択された美術館データを一時保存
  def handle_museum_selection(selected_museum_id)
    if selected_museum_id.present?
      session[:selected_museum_id] = selected_museum_id
      redirect_to select_exhibitions_path
    else
      set_flash_message("選択に問題があります")
      redirect_to select_museums_path
    end
  end

  # 一時保存した美術館データを変数に格納
  def handle_museum_selection_session(selected_museum_session)
    if selected_museum_session.present?
      @selected_museum_id = selected_museum_session
      session.delete(:selected_museum_id)
    else
      set_flash_message("選択に問題があります")
      redirect_to select_museums_path
    end
  end

  # 選択された展示会データを一時保存
  def handle_exhibition_selection(selected_exhibition_id)
    if selected_exhibition_id.present?
      session[:selected_exhibition_id] = selected_exhibition_id
      redirect_to new_review_path
    else
      set_flash_message("選択に問題があります")
      redirect_to select_museums_path
    end
  end

  # 一時保存した展示会データを変数に格納
  def handle_exhibition_selection_session(selected_exhibition_session)
    if selected_exhibition_session.present?
      @selected_exhibition_id = selected_exhibition_session
    else
      set_flash_message("選択に問題があります")
      redirect_to select_museums_path
    end
  end

  # # タグをレビューに紐づける
  # def extract_tags_from_space_separated_string
  #   @review.tags.destroy_all
  #   if params[:review][:tags_name].present?
  #     # フォームから送信されたタグの文字列を受け取り、スペース（半角・全角）で分割する
  #     tag_names = params[:review][:tags_name].split(/[ 　]+/).map(&:strip)
  #     # 各タグをデータベースに保存
  #     tag_names.each do |tag_name|
  #       # タグ名から記号を削除して保存
  #       filtered_tag_name = tag_name.gsub(/[^0-9A-Za-zぁ-んァ-ヶ一-龠々ー〆ヽヾ゛゜]/, '')
  #       if filtered_tag_name.present?
  #         tag = Tag.find_or_create_by(name: filtered_tag_name)
  #         unless @review.tags.include?(tag)
  #           @review.tags << tag
  #         end
  #       end
  #     end
  #   end
  # end

  def extract_tags_from_google_vision_api
    tags = Vision.get_image_data(review_params[:review_image])
    tags.each do |tag|
      @review.tags.create(name: tag)
    end
  end

  def review_params
    params.require(:review).permit(:body, :review_image)
  end

  def redirect_if_review_not_found(review)
    if review.member.is_active == false || review.member.name == "guest"
      set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
      redirect_to reviews_path
    end
  end

  def ensure_correct_member
    @review = Review.find(params[:id])
    unless @review.member == current_member
    set_flash_message("権限がありません ブロックされました")
    redirect_to reviews_path
    end
  end

  def fetch_reviews(member_ids = nil)
    reviews = Review.includes(:member, :review_comments, :exhibition)
                    .where(members: { is_active: true })
                    .where(exhibitions: { is_active: true })

    reviews = reviews.where(member_id: member_ids) if member_ids.present?
    reviews = reviews.order(created_at: :desc).page(params[:page])
    reviews
  end

  # エラー箇所に元のデータを代入する
  def copy_error_attributes_from_original_review
    @original_review.attributes.each do |attr, value|
      @review[attr] = value unless @review.errors[attr].empty?
    end
  end
end
