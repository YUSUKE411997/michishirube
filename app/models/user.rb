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
  has_many :previews, dependent: :destroy
  has_many :plans, dependent: :destroy


  attachment :profile_image

  validates :name, presence: true, length: {maximum: 50}
  validates :profession, length: {maximum: 20}
  validates :introduction, length: {maximum: 1000}

  #ログイン時、退会済みのユーザーを弾く
  def active_for_authentication?
    super && (self.is_valid == true)
  end

  # フォロー済みか判別
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  # admin側のユーザー検索
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

  # 投稿を閲覧したことがあるか判別
  def previewed?(post_id)
    post_ids = self.posts.pluck(:id)
    self.previews.where(post_id: post_id).where.not(post_id: post_ids).exists?
  end

  # 閲覧した時刻を出す為に、検索
  def preview_time(post_id)
    self.previews.find_by(post_id: post_id)
  end

  # １週間以内にやってみたい投稿をカレンダーに登録したか判別
  def planed?(current_user)
    Plan.where(user_id: current_user.id, start_time: Time.zone.now.end_of_day..Time.current.weeks_since(1)).exists?
  end

end
