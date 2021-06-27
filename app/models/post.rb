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
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :reposts, dependent: :destroy
  has_many :timelines, dependent: :destroy
  has_many :previews, dependent: :destroy
  has_many :plans, dependent: :destroy
  belongs_to :user

  validates :user_id, :title, :body, :type, presence: true
  validates :title, length: {maximum: 50}

  # いいねしているか判別
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # 投稿を検索
  def self.search(word)
    where(["title LIKE? OR body LIKE?" , "%#{word}%", "%#{word}%"])
  end

  # タイプ別にいいねランキング表示（１週間ごと）
  def self.create_ranks_type_likes(type)
    posts_type = Post.joins(:likes).where(type: type, created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day).limit(10)
    posts_type.sort_by {|post| post.likes.size}.reverse
  end

  # リポストのランキング表示（１週間ごと）
  def self.create_ranks_repost
    Post.find(Repost.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day).group(:post_id).limit(10).order('count(post_id)desc').pluck(:post_id))
  end

  # Previewのランキング表示（１週間ごと）
  def self.create_ranks_preview
    Post.find(Preview.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day).group(:post_id).limit(10).order('count(post_id)desc').pluck(:post_id))
  end

# いいね通知
  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
        )

        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
    end
  end

  # リポスト通知
  def create_notification_repost!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user, user_id, id, 'repost'])

    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'repost'
        )

      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメント通知
  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end

    save_notification_comment!(current_user, comment_id, user_id)
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  # タグ付け機能
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(tag_name: old_tag)
    end

    new_tags.each do |new_tag|
      new_post_tag = Tag.find_or_create_by(tag_name: new_tag)
      self.tags << new_post_tag
    end
  end

  # リポストしたユーザーの名前を抽出
  def repost_user_name(current_user)
    follow_user_ids = current_user.followings.select(:id)
    repost_user = self.reposts.where("user_id IN (:follow_user_ids) OR user_id = user_id", follow_user_ids: follow_user_ids, user_id: current_user.id).order(created_at: :desc).limit(1).pluck(:user_id)
    user_name = User.find(repost_user).pluck(:name).first

    if current_user.name == user_name
      "あなた"
    else
      user_name
    end
  end

end
