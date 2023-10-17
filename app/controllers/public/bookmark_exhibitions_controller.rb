class Public::BookmarkExhibitionsController < ApplicationController
  before_action :authenticate_member!
  before_action :member_is_guest?, only: [:create, :destroy]

  def create
    @exhibition = Exhibition.find(params[:exhibition_id])
    bookmark_exhibition = current_member.bookmark_exhibitions.new(exhibition_id: @exhibition.id)
    bookmark_exhibition.save
    bookmark_exhibition_count
  end

  def index
    @bookmark_exhibitions = current_member.exhibitions.where(is_active: :true)
                                                      .page(params[:page]).per(20)
    extract_bookmark_count
    extract_review
  end

  def destroy
    @exhibition = Exhibition.find(params[:exhibition_id])
    bookmark_exhibition = current_member.bookmark_exhibitions.find_by(exhibition_id: @exhibition.id)
    bookmark_exhibition.destroy
    bookmark_exhibition_count
  end

  def bookmark_exhibition_count
    @bookmark_exhibition_counts = BookmarkExhibition.joins(:member).where(exhibition_id: @exhibition.id, members: { is_active: true }).count
  end

  def extract_bookmark_count
    @bookmark_exhibition_counts = {}
    @bookmark_exhibitions.each do |exhibition|
      @bookmark_exhibition_counts[exhibition.id] = BookmarkExhibition.joins(:member).where(exhibition_id: exhibition.id, members: { is_active: true }).count
    end
  end

  def extract_review
    @review = {}
    @bookmark_exhibitions.each do |exhibition|
      @review[exhibition.id] = Review.joins(:member).where(exhibition_id: exhibition.id, members: { is_active: true })
    end
  end
end
