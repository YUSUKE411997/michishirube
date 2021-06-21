class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :content, :user_id, :room_id,  presence: true
end
