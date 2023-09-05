class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :follower,class_name: "Relationship",foreign_key: "follower_id",dependent: :destroy
  has_many :followed,class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy
  has_many :followings, through: :follower, source: :followed
  has_many :followers, through: :followed, source: :follower
  has_one :reports, dependent: :destroy
  has_many :member_tags, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :review_comments, dependent: :destroy
  has_many :bookmark_museums, dependent: :destroy
  has_many :bookmark_exhibitions, dependent: :destroy
  
  def follow(member_id)
    follower.create(followed_id: member_id)
  end

  def unfollow(member_id)
    follower.find_by(followed_id: member_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end
  
  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join("app/assets/images/no_image.jpg")
    profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
