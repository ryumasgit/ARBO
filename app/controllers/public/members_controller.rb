class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :member_is_guest?, except: [:show]
  before_action :get_current_member, only: [:edit, :update]
  before_action :get_member_name, only: [:show, :edit, :update, :withdraw]
  before_action :ensure_correct_member,  only: [:edit, :update, :withdraw]
  rescue_from ActiveRecord::RecordNotFound, with: :public_member_handle_record_not_found


  def show
    @reviews = get_reviews
    @favorited_reviews = get_favorited_reviews
    @total_favorited_count = calculate_total_favorited_count
    @total_commented_count = calculate_total_commented_count
    @total_visited_museum = calculate_total_visited_museum
    @total_visited_exhibition = calculate_total_visited_exhibition
    @earned_badges = get_earned_badges
  end

  def edit
  end

  def update
    @original_member = current_member

    if @member.update(member_params)
      set_flash_message("メンバー情報の保存に成功しました")
      redirect_to member_my_page_path(member_member_name: @member.name)
    else
      copy_error_attributes_from_original_member
      set_flash_message("メンバー情報の保存に失敗しました")
      render :edit
    end
  end

  def withdraw
    if current_member.update(is_active: false)
      reset_session
      set_flash_message("退会が完了しました")
      redirect_to root_path
    else
      set_flash_message("退会に失敗しました")
      render :confirm_withdraw
    end
  end

  protected

  def get_reviews
   @member.reviews
          .order(created_at: :desc)
          .page(params[:page])
  end

  # メンバーがいいねしたレビュー取得
  def get_favorited_reviews
    @member.favorite_reviews
          .joins(:member)
          .where(members: { is_active: true })
          .order(created_at: :desc)
          .page(params[:page])
  end

  # メンバーが受けたいいね数取得
  def calculate_total_favorited_count
    Favorite.joins(review: :member)
            .where(reviews: { member_id: @member.id })
            .joins("INNER JOIN members AS favoriting_members ON favoriting_members.id = favorites.member_id")
            .where(favoriting_members: { is_active: true })
            .count
  end

  # メンバーが受けたコメント数取得
  def calculate_total_commented_count
    ReviewComment.joins(review: :member)
          .where(review: { member_id: @member.id })
          .joins("INNER JOIN members AS commenting_members ON commenting_members.id = review_comments.member_id")
          .where(commenting_members: { is_active: true })
          .count
  end

  # メンバーが訪れた美術館数取得
  def calculate_total_visited_museum
    Museum.joins(exhibitions: {reviews: :member})
          .where(museums: { is_active: true })
          .where(members: { id: @member.id })
          .distinct
          .count
  end

  # メンバーが訪れた展示会数取得
  def calculate_total_visited_exhibition
    Exhibition.joins(reviews: :member)
          .where(exhibitions: { is_active: true })
          .where(members: { id: @member.id })
          .distinct
          .count
  end

  # メンバーが獲得したバッジ取得
  def get_earned_badges
    EarnedBadge.joins(:member)
      .joins(:badge)
      .where(members: { id: @member.id })
      .where(badges: { is_active: true })
      .order(created_at: :desc)
  end

  def member_params
    params.require(:member).permit(:member_image, :name, :introduction, :email, :is_active)
  end

  def get_current_member
    @member = current_member
  end

  def get_member_name
    @member = Member.find_by(name: params[:member_member_name])

    if @member.nil? || @member.is_active == false || @member.is_guest
      set_flash_message("メンバーが見つかりません")
      redirect_to root_path
    end
  end

  def ensure_correct_member
    unless @member == current_member
    set_flash_message("権限がありません ブロックされました")
    redirect_to root_path
    end
  end

  # エラー箇所に元のデータを代入する
  def copy_error_attributes_from_original_member
    @original_member.attributes.each do |attr, value|
      @member[attr] = value unless @member.errors[attr].empty?
      @member.introduction = @original_member.introduction
    end
  end
end
