class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :follower, source: :followed
  has_many :followers, through: :followed, source: :follower
  has_one :report, dependent: :destroy
  has_many :earned_badges, dependent: :destroy
  has_many :badges, through: :earned_badges
  has_many :member_tags, dependent: :destroy
  has_many :tags, through: :member_tags
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_reviews, through: :favorites, source: :review
  has_many :review_comments, dependent: :destroy
  has_many :bookmark_museums, dependent: :destroy
  has_many :museums, through: :bookmark_museums
  has_many :bookmark_exhibitions, dependent: :destroy
  has_many :exhibitions, through: :bookmark_exhibitions

  has_one_attached :member_image

  validates :member_name, presence: true, uniqueness: true, length: {in: 3..25}
  validates :introduction, length: { maximum: 255 }
  validates :is_active, presence: true, inclusion: { in: [true, false] }
  validates :is_guest, inclusion: { in: [true, false] }

  def follow(member_id)
    follower.create(followed_id: member_id)
  end

  def unfollow(member_id)
    follower.find_by(followed_id: member_id).destroy
  end

  def following?(member)
    followings.include?(member)
  end

  def get_member_image(width, height)
    if member_image.attached?
      member_image.variant(resize_to_limit: [width, height]).processed
    else
      ActionController::Base.helpers.asset_path("default_member_image.jpeg")
    end
  end

  def guest?
    is_guest
  end

GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.member_name = "guest"
      member.is_guest = "true"
    end
  end
end