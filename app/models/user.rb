class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :user_likes, through: :likes, source: :post
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following
  has_many :active_notifications, class_name: "Notification", foreign_key: :visitor_id, dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: :visited_id, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :reposts, dependent: :destroy
  has_many :timelines, dependent: :destroy

  attachment :profile_image

  validates :name, presence: true

  #ログイン時、退会済みのユーザーを弾く
  def active_for_authentication?
    super && (self.is_valid == true)
  end

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.search(word)
    where(["name LIKE?", "%#{word}%"])
  end

  # フォローされたら通知
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # タイプ別に表示
  def user_type_page(type)
    case type
      when "気ままに"
        posts.where(type: 0)
      when "やってみたい"
        posts.where(type: 1)
      when "やってみた"
        posts.where(type: 2)
    end
  end

  # 自分がリポストしているか判別
  def reposted?(post_id)
    self.reposts.where(post_id: post_id).exists?
  end

end
