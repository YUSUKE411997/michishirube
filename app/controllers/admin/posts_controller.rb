class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.includes(:user).page(params[:page]).order(created_at: :desc)
  end

  def type_index
    type_name = Post.find_by(type: params[:type])
    @posts = Post.where(type: type_name.type).includes(:user)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
end
