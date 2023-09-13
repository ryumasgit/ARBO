class Public::ReviewsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_correct_member,  except: [:new, :show, :index]

  def new
  end

  def create
  end

  def show
    @review = Review.find(params[:id])
    redirect_if_member_not_found(@review)
  end

  def index
    reviews = Review.order(created_at: :desc).page(params[:page]).per(50)
    @reviews = reviews.includes(:member).where(members: { is_active: true })
  end


  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def redirect_if_member_not_found(review)
    if review.nil? || review.member.is_active == false || review.member.name == "guest"
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
end
