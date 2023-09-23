class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :follower, source: :followed
  has_many :followers, through: :followed, source: :follower
  has_many :earned_badges, dependent: :destroy
  has_many :badges, through: :earned_badges, source: :badge
  has_many :member_tags, dependent: :destroy
  has_many :tags, through: :member_tags
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_reviews, through: :favorites, source: :review
  has_many :favorite_members, through: :favorites, source: :member
  has_many :review_comments, dependent: :destroy
  has_many :bookmark_museums, dependent: :destroy
  has_many :museums, through: :bookmark_museums
  has_many :bookmark_exhibitions, dependent: :destroy
  has_many :exhibitions, through: :bookmark_exhibitions
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy


  has_one_attached :member_image

  validates :name, presence: true, uniqueness: true, length: { maximum: 25 }
  validates :introduction, length: { maximum: 255 }
  validates :is_active, inclusion: { in: [true, false] }
  validates :is_guest, inclusion: { in: [true, false] }

  def follow(name)
    followed_member = Member.find_by(name: name)
    follower.create(followed: followed_member)
    create_notification_follow!(current_member)
    BadgeJob.perform_later(followed_member)
  end

  def unfollow(name)
    followed_member = Member.find_by(name: name)
    follower.find_by(followed: followed_member).destroy
  end

  def following?(member)
    followings.include?(member)
  end

  def get_member_image(width, height)
    unless member_image.attached?
      file_path = Rails.root.join("app/assets/images/member_image.jpeg")
      member_image.attach(io: File.open(file_path), filename: "member_image.jpeg", content_type: "image/jpeg")
    else
      member_image.variant(resize: "#{width}x#{height}^", gravity: 'center', extent: "#{width}x#{height}").processed
    end
  end

  def is_guest?
    is_guest
  end

  GUEST_MEMBER_EMAIL = "guest@example.com"
  GUEST_MEMBER_NAME = "guest"

  def self.guest
    find_or_create_by!(email: GUEST_MEMBER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = GUEST_MEMBER_NAME
      member.is_guest = "true"
    end
  end
  
  def create_notification_follow!(current_member)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_member.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end