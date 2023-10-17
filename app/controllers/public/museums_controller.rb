class Public::MuseumsController < ApplicationController
  before_action :authenticate_member!
  rescue_from ActiveRecord::RecordNotFound, with: :public_event_handle_record_not_found

  def show
    @museum = Museum.find(params[:id])
    return museum_not_active_redirect unless @museum.is_active?

    @exhibitions = @museum.exhibitions.where(is_active: :true).page(params[:page])
    @bookmark_museum_counts = BookmarkMuseum.joins(:member).where(museum_id: @museum.id, members: { is_active: true }).count
  end

  def index
    @museums = Museum.includes(:exhibitions).where(is_active: true).page(params[:page])
    @exhibitions = Exhibition.includes(:artists).where(museum_id: @museums.pluck(:id), is_active: true).page(params[:page])
    @artists = Artist.includes(:exhibitions).where(is_active: true).page(params[:page])
    extract_bookmark_count
    extract_review
  end

  protected

  def museum_not_active_redirect
    set_flash_message("指定されたURLは見つかりませんでした、現在非公開の可能性があります。")
    redirect_to museums_path
  end

  def extract_bookmark_count
    @bookmark_museum_counts = {}
    @bookmark_exhibition_counts = {}
    @museums.each do |museum|
      @bookmark_museum_counts[museum.id] = BookmarkMuseum.joins(:member).where(museum_id: museum.id, members: { is_active: true }).count
    end
    @exhibitions.each do |exhibition|
      @bookmark_exhibition_counts[exhibition.id] = BookmarkExhibition.joins(:member).where(exhibition_id: exhibition.id, members: { is_active: true }).count
    end
  end
  
  def extract_review
    @review = {}
    @exhibitions.each do |exhibition|
      @review[exhibition.id] = Review.joins(:member).where(exhibition_id: exhibition.id, members: { is_active: true })
    end
  end
end
