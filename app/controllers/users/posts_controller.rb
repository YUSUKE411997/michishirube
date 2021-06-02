class Users::PostsController < ApplicationController


  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
  end

  def type_index
    type_name = Post.find_by(type: params[:type])
    @posts = Post.where(type: type_name.type)
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :type, :user_id)
  end

end
