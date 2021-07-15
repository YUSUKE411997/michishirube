class Users::RepostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_repost = Repost.find_by(user_id: current_user.id, post_id: @post.id)

    if current_repost.nil?
      repost = Repost.new(user_id: current_user.id, post_id: @post.id)
      repost.save
      Timeline.create_timeline_repost(repost.id, current_user, repost.post_id)
    end
    @post.create_notification_repost!(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_repost = current_user.reposts.find_by(post_id: @post.id)

    if current_repost.present?
      current_repost.destroy
    end
  end
end
