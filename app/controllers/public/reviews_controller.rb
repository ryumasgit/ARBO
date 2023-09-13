class Public::ReviewsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_correct_member,  except: [:new, :show, :index]
  rescue_from ActiveRecord::RecordNotFound, with: :public_review_handle_record_not_found

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)

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
    reviews = Review.order(created_at: :desc).page(params[:page]).per(50)
    @reviews = reviews.includes(:member).where(members: { is_active: true })
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

  def review_params
    params.require(:review).permit(:member_id, :exhibition_id, :body, :review_image)
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
