class Badge < ApplicationRecord
  has_many :earned_badges, dependent: :destroy
  has_many :members, through: :earned_badges

  has_one_attached :badge_image

  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true, length: { maximum: 255 }
  validates :is_active, inclusion: { in: [true, false] }

  def get_badge_image(width, height)
    badge_image.variant(resize: "#{width}x#{height}^", gravity: 'center', extent: "#{width}x#{height}").processed
  end

  # def create_notification_earned_badges!(current_member, badge_id)
  #   temp = Notification.where(["visitor_id = ? and visited_id = ? and badge_id = ? and action = ? ", current_member.id, current_member.id, badge_id, 'badge'])
  #   if temp.blank?
  #     notification = current_member.active_notifications.new(
  #       visited_id: current_member.id,
  #       badge_id: badge_id,
  #       action: 'badge'
  #     )
  #     notification.save if notification.valid?
  #   end
  # end
end