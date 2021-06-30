class Users::TimelinesController < ApplicationController
  before_action :authenticate_user!

  def index
    @timelines = Timeline.timeline_posts(current_user).page(params[:page])
    followings_users_ids = current_user.followings.pluck(:id)
    followings_like_post_ids = Like.where(user_id: followings_users_ids).pluck(:post_id)
    @follow_like_post = Post.where(id: followings_like_post_ids, created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day).order(created_at: :desc).sample(5)
  end
end
