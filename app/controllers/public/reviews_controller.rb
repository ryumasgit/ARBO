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

    if session_museum_present?
      @selected_museum_id = session[:selected_museum_id]
      session.delete(:selected_museum_id)
    else
      set_flash_message("選択に問題があります")
      redirect_to select_museums_path
    end
  end

  def selected_museum
    if params_museum_id_present?
      session[:selected_museum_id] = params[:museum][:museum_id]
      redirect_to select_exhibitions_path
    else
      set_flash_message("選択に問題があります")
      redirect_to select_museums_path
    end
  end

  def selected_exhibition
    if params_exhibition_id_present?
      session[:selected_exhibition_id] = params[:exhibition][:exhibition_id]
      redirect_to new_review_path
    else
      set_flash_message("選択に問題があります")
      redirect_to select_museums_path
    end
  end

  def new
    @review = Review.new

    if session_exhibition_present?
      @selected_exhibition_id = session[:selected_exhibition_id]
      session.delete(:selected_exhibition_id)
    else
      set_flash_message("選択に問題があります")
      redirect_to select_museums_path
    end
  end

  def create
    @review = Review.new(review_params)
    @review.member_id = current_member.id
    @review.exhibition_id = params[:review][:exhibition_id]

    if @review.save
      set_flash_message("レビューの作成に成功しました")
      redirect_to review_path(@review)
    else
      set_flash_message("レビューの作成に失敗しました")
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    redirect_if_review_not_found(@review)
  end

  def index
    @all_reviews = Review.includes(:member)
                .where(members: { is_active: true })
                .order(created_at: :desc)
                .page(params[:page])
                .per(50)

    following_member_ids = current_member.followings.pluck(:id)
    @following_member_reviews = Review.includes(:member)
                .where(members: { is_active: true })
                .where(member_id: following_member_ids)
                .order(created_at: :desc)
                .page(params[:page])
                .per(50)
  end


  def edit
  end

  def update
    @original_review = Review.find(params[:id])

    if @review.update(review_params)
      set_flash_message("レビュー情報の保存に成功しました")
      redirect_to review_path(@review)
    else
      copy_error_attributes_from_original_review
      set_flash_message("レビュー情報の保存に失敗しました")
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

  def params_museum_id_present?
    params[:museum][:museum_id].present?
  end

  def session_museum_present?
    session[:selected_museum_id].present?
  end

  def params_exhibition_id_present?
    params[:exhibition][:exhibition_id].present?
  end

  def session_exhibition_present?
    session[:selected_exhibition_id].present?
  end

  def review_params
    params.require(:review).permit(:body, :review_image)
  end

  def redirect_if_review_not_found(review)
    if review.member.is_active == false || review.member.name == "guest"
      set_flash_message("レビューが見つかりません")
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

  # エラー箇所に元のデータを代入する
  def copy_error_attributes_from_original_review
    @original_review.attributes.each do |attr, value|
      @review[attr] = value unless @review.errors[attr].empty?
    end
  end
end
