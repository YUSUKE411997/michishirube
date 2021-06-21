class Users::PostsController < ApplicationController


  def index
    posts = Post.includes(:user)
    @posts = posts.preload(:comments, :likes).page(params[:page]).order(created_at: :desc)
    @random = Post.where(created_at: Time.zone.now.all_day).sample(5)
    @post = Post.new
    @tag_lists = Tag.all
    @tag_ranks = Tag.create_ranks_tag
    likes = Post.eager_load(:likes)
    @ranks_0 = likes.create_ranks_type_likes(0)
    @ranks_1 = likes.create_ranks_type_likes(1)
    @ranks_2 = likes.create_ranks_type_likes(2)
    @repost_ranks = Post.create_ranks_repost
  end

  def ranks_show
    @word = params[:word]
    case @word
      when "タグ"
        @tags = Tag.create_ranks_tag
      when "リポスト"
        @posts = Post.create_ranks_repost
      when "気ままに"
        @posts = Post.eager_load(:likes).create_ranks_type_likes(0)
      when "やってみたい"
        @posts = Post.eager_load(:likes).create_ranks_type_likes(1)
      when "やってみた"
        @posts = Post.eager_load(:likes).create_ranks_type_likes(2)
    end
  end

  def type_index
    @type_name = Post.find_by(type: params[:type])
    @posts = Post.includes(:user, :comments, :likes).where(type: @type_name.type).page(params[:page]).order(created_at: :desc)
  end

  def tag_index
    @tag_lists = Tag.page(params[:page]).order(created_at: :desc)
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.includes(:user).page(params[:page]).order(created_at: :desc)
  end

  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:tag_name].split(/[[:blank:]]+/).select(&:present?)
    if @post.save
       @post.save_tag(tag_list)
       Timeline.create_timeline_post(current_user, @post.id)
      redirect_to posts_path
    else
      # indexに返す為に記述
      posts = Post.includes(:user)
      @posts = posts.preload(:comments, :likes).page(params[:page]).order(created_at: :desc)
      @random = Post.where(created_at: Time.zone.now.all_day).sample(5)
      @post = Post.new
      @tag_lists = Tag.all
      @tag_ranks = Tag.create_ranks_tag
      likes = Post.eager_load(:likes)
      @ranks_0 = likes.create_ranks_type_likes(0)
      @ranks_1 = likes.create_ranks_type_likes(1)
      @ranks_2 = likes.create_ranks_type_likes(2)
      @repost_ranks = Post.create_ranks_repost
      render :index
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
    @post_tags = @post.tags
    if user_signed_in?
      Preview.create_preview(@post.id, current_user.id)
    end
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
