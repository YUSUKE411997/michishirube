class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  attachment :profile_image

  validates :name, presence: true

  def active_for_authentication?   #ログイン時にバリデーションを足したい場合(今回退会済みのユーザーを弾く)
    super && (self.is_valid == true)
  end

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
end
