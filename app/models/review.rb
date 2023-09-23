class Review < ApplicationRecord
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags
  has_many :favorites, dependent: :destroy
  has_many :favorite_reviews, through: :favorites, source: :member
  has_many :review_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :member
  belongs_to :exhibition


  has_one_attached :review_image

  validates :body, presence: true, length: { maximum: 255 }

  def get_review_image(width, height)
    if review_image.attached?
      review_image.variant(resize_to_limit: [width, height]).processed
    end
  end

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
  
  def create_notification_like!(current_member)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and member_id = ? and action = ? ", current_member.id, member_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_member.active_notifications.new(
        review_id: id,
        visited_id: member_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  def create_notification_comment!(current_member, review_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = ReviewComment.select(:member_id).where(review_id: id).where.not(member_id: current_member.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_member, review_comment_id, temp_id['member_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_member, review_comment_id, member_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_member, review_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_member.active_notifications.new(
      review_id: id,
      review_comment_id: review_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end