class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.includes(:user).page(params[:page]).order(created_at: :desc)
  end

  def type_index
    @type_name = params[:type]
    @posts = Post.includes(:user).where(type: @type_name).page(params[:page]).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @comments = @post.comments.includes(:user)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
end
