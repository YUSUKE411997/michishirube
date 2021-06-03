class Comment < ApplicationRecord
  
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :post
  
  validates :user_id, :post_id, :content, presence: true
end
