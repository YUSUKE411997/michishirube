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

  attachment :profile_image

  validates :name, presence: true

  def active_for_authentication?   #ログイン時にバリデーションを足したい場合(今回退会済みのユーザーを弾く)
    super && (self.is_valid == true)
  end

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.search(word)
    where(["name LIKE?", "%#{word}%"])
  end

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

  def post_and_reposts
    follow_user_ids = self.followings.select(:id)
    repost_ids = Repost.where("user_id IN (:follow_user_ids) OR user_id = :user_id", follow_user_ids: follow_user_ids, user_id: self.id).select(:post_id)
    Post.where("id IN (:repost_ids) OR user_id IN (:follow_user_ids) OR user_id = :user_id", repost_ids: repost_ids, follow_user_ids: follow_user_ids, user_id: self.id)

    # post << Post.where(id: repost_ids)
    # Post.where(user_id: follow_user, user_id: self.id)
    #       .or(Post.where(user_id: Repost.where(user_id: follow_user.ids, user_id: self.id)))
    #       .or(select(:post_id).from(reposts).where(user_id: follow_user.ids, user_id: self.id))
    # bbb = Repost.select(:post_id).where(user_id: follow_user.ids, user_id: self.id)
    # select(:id).from(Repost)
    #     following_ids = self.following.select(:id)
    # Post.where("user_id IN (:following_ids)
    #             OR user_id = :user_id", following_ids: following_ids, user_id: id)
  end

  def reposted?(post_id)
    self.reposts.where(post_id: post_id).exists?
  end

end
