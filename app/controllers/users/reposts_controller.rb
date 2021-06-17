class Users::RepostsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    current_repost = Repost.find_by(user_id: current_user.id, post_id: @post.id)

    if current_repost.nil?
      Repost.create(user_id: current_user.id, post_id: @post.id)
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
