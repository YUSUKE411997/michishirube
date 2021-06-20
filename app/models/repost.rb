class Repost < ApplicationRecord
  
  has_many :timelines
  belongs_to :user
  belongs_to :post
  
  validates :user_id, :post_id, presence: true
end
