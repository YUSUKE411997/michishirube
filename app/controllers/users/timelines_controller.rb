class Users::TimelinesController < ApplicationController

  def index
    @timelines = Timeline.timeline_posts(current_user)
    followings_users = current_user.followings
    followings_users_ids = followings_users.pluck(:id)
    followings_users_post_ids = Like.where(user_id: followings_users_ids).pluck(:post_id)
    @follow_like_post = Post.where(id: followings_users_post_ids, created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day).limit(5)
  end
end
