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
    handle_museum_selection
  end

  def selected_museum
    handle_museum_selection(params[:museum][:museum_id])
  end

  def selected_exhibition
    handle_exhibition_selection(params[:exhibition][:exhibition_id])
  end

  def new
    @review = Review.new
    handle_exhibition_selection(session[:selected_exhibition_id])
  end

  def create
    @review = build_review_from_params(review_params)
    handle_review_creation(@review)
  end

  def show
    @review = find_review(params[:id])
    @review_comments = fetch_review_comments(@review)
    @review_comment = ReviewComment.new
  end

  def index
    @all_reviews = fetch_all_reviews
    @following_member_reviews = fetch_following_member_reviews
  end

  def edit
  end

  def update
    @original_review = find_review(params[:id])
    handle_review_update(@original_review, @review)
  end

  def destroy
    handle_review_deletion(@review)
  end

  protected

  # ... ここに前半部分のプライベートメソッドを追加

  def handle_museum_selection(selected_museum_id = nil)
    if selected_museum_id.present?
      session[:selected_museum_id] = selected_museum_id
      redirect_to select_exhibitions_path
    else
      set_flash_message("選択に問題があります")
      redirect_to select_museums_path
    end
  end

  def handle_exhibition_selection(selected_exhibition_id = nil)
    if selected_exhibition_id.present?
      session[:selected_exhibition_id] = selected_exhibition_id
      redirect_to new_review_path
    else
      set_flash_message("選択に問題があります")
      redirect_to select_museums_path
    end
  end

  def build_review_from_params(review_params)
    @review = Review.new(review_params)
    @review.member_id = current_member.id
    @review.exhibition_id = params[:review][:exhibition_id]
    @review
  end

  def find_review(review_id)
    Review.find(review_id)
  end

  def handle_review_creation(review)
    if review.save
      set_flash_message("レビューの作成に成功しました")
      redirect_to review_path(review)
    else
      set_flash_message("レビューの作成に失敗しました")
      render :new
    end
  end

  # ... ここに後半部分のプライベートメソッドを追加
end
