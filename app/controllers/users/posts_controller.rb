class Users::PostsController < ApplicationController


  def index
    @posts = Post.page(params[:page]).order(created_at: :desc)
    @post = Post.new
    @tag_lists = Tag.all
  end

  def type_index
    @type_name = Post.find_by(type: params[:type])
    @posts = Post.where(type: @type_name.type).page(params[:page]).order(created_at: :desc)
  end

  def tag_index
    @tag_lists = Tag.page(params[:page]).order(created_at: :desc)
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.page(params[:page]).order(created_at: :desc)
  end

  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:tag_name].split(/[[:blank:]]+/).select(&:present?)
    if @post.save
       @post.save_tag(tag_list)
      redirect_to posts_path
    else
      @tag_lists = Tag.all
      @posts = Post.page(params[:page]).order(created_at: :desc)
      render :index
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
    @post_tags = @post.tags
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
