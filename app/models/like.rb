class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, :post_id, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
