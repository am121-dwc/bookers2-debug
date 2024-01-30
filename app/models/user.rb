class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :favorites, dependent: :destroy
  has_many :books
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image
  # --フォロー・フォロワー機能--
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :followers, source: :followed

  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_users, through: :followeds, source: :follower
  # --グループ機能--
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users

  # --DM機能--
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  validates :introduction,
  length: { maximum: 50}


  def follow(user_id)
    followers.create(followed_id: user_id)
  end
  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    following_users.include?(user)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

  def get_profile_image()
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
