class Admin::ReviewsController < ApplicationController
  before_action :get_review_id, except: [:index]

  def show
  end

  def index
  end

  def destroy
    delete_review_images
    if @review.destroy
      set_flash_message("レビュー情報の削除に成功しました")
      flash[:tab] = 'section2'
      redirect_to admin_reviews_path
    else
      set_flash_message("レビュー情報の削除に失敗しました")
      render :show
    end
  end

  protected

  def review_params
    params.require(:review).permit(:title, :body, review_images: [])
  end

  def get_review_id
    @review = Review.find(params[:id])
  end

  def delete_review_images
    @review.review_images.each do |image|
      image.purge
    end
  end
end