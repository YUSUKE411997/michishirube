class Post < ApplicationRecord
  self.inheritance_column = :_type_disabled
  
  enum type: {
    気ままに投稿: 0,
    やってみたいを投稿: 1,
    やってみたを投稿: 2
  }
  
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user

  validates :user_id, :title, :body, :type, presence: true
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
  
  def self.search(word)
    where(["title LIKE? OR body LIKE?", "%#{word}%", "%#{word}%"])
  end
end
