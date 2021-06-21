class Repost < ApplicationRecord
  
  has_many :timelines, dependent: :destroy
  belongs_to :user
  belongs_to :post
  
  validates :user_id, :post_id, presence: true
end
