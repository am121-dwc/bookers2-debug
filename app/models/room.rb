class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  das_many :chats, dependent: :destroy
end
