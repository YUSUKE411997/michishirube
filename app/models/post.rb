class Post < ApplicationRecord
  self.inheritance_column = :_type_disabled
  enum type: {
    気ままに投稿: 0,
    やってみたいを投稿: 1,
    やってみたを投稿: 2
  }
  
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :user_id, :title, :body, :type, presence: true
end
