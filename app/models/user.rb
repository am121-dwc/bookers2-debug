class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :favorites, dependent: :destroy
  has_many :books
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image
  
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, through: :relationships, source: :followed
  
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  validates :introduction,
  length: { maximum: 50}


  def get_profile_image()
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
