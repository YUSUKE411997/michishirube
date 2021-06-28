class Users::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_likes = current_user.likes.find_by(post_id: @post.id, user_id: current_user.id)
    if current_likes.blank?
      like = current_user.likes.new(post_id: @post.id)
      like.save
    end
    @post.create_notification_like!(current_user)

  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
  end
end

