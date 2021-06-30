class Timeline < ApplicationRecord
  default_scope -> {order(created_at: :desc)}

  belongs_to :user
  belongs_to :post
  belongs_to :repost, optional: true

  validates :user_id, :post_id, presence: true

  # ポストを作成した時、作成
  def self.create_timeline_post(current_user, post_id)
    Timeline.create(user_id: current_user.id, post_id: post_id)
  end

  # リポスト作成時に作成
  def self.create_timeline_repost(repost_id, current_user, post_id)
    repost = Timeline.find_by(repost_id: repost_id, user_id: current_user.id, post_id: post_id)

    if repost.blank?
      Timeline.create(repost_id: repost_id,
      user_id: current_user.id,
      post_id: post_id
      )
    end
  end


  def self.timeline_posts(current_user)
    follow_user_ids = current_user.followings.select(:id)
    Timeline.where("user_id IN (:follow_user_ids) OR user_id = :user_id", follow_user_ids: follow_user_ids, user_id: current_user.id)

  end

  # リポストしたユーザーの名前を抽出
  def repost_user_name(current_user)
    user_name = self.user.name

    if current_user.name == user_name
      "あなた"
    else
      user_name
    end
  end

end
