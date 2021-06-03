class Post < ApplicationRecord
  self.inheritance_column = :_type_disabled

  enum type: {
    気ままに投稿: 0,
    やってみたいを投稿: 1,
    やってみたを投稿: 2
  }

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :user

  validates :user_id, :title, :body, :type, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def self.search(word)
    where(["title LIKE? OR body LIKE?", "%#{word}%", "%#{word}%"])
  end

# いいね通知
  def create_notification_like!(current_user)
    # いいねされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'like'])
  # いいねされてなければ通知レコード作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
        )
    # 自分の投稿に自分がいいねした場合、通知済み
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメント通知
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
