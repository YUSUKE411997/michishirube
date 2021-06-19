class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :whithdraw]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:comments, :likes).page(params[:page]).order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    user.update(user_params)
    redirect_to user_path(user)
  end

  def destroy_confirm
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_valid: false)
    reset_session
    flash[:notice] = "退会を確認しました"
    redirect_to root_path
  end

  def follows
    @users = User.find(params[:id]).followings
  end

  def followers
    @users = User.find(params[:id]).followers
  end

  def timeline
    user = User.find(current_user.id)
    followings_users = user.followings
    # @posts = Post.includes(:user, :comments, :likes).where(user_id: followings_users).page(params[:page]).order(created_at: :desc)
    @posts = user.post_and_reposts.page(params[:page]).order(created_at: :desc)

    # ここから
    # @obj = []
    # @obj_1 = []
    # repost_ids = User.retwitter(current_user)
    # reposts = Repost.where(id: repost_ids)
    # repost_post_ids = reposts.pluck(:post_id)
    # posts.each do |post|
    #   # retweet されてる投稿なのか判定
    #   if repost_post_ids.include?(post.id)

    #     repost = reposts.where(post_id: post.id)
    #     # post_clone = post.clone
    #     # # @obj << post_clone
    #     # post_clone.update_attribute(created_at: repost)
    #     # byebug
    #     # post_clone.created_at = repost
    #     @obj_1 << repost

    #   else
    #     @obj << post
    #   end
    # end
    # byebug
    # (@obj + @obj_1).sort_by(&:created_at).reverse
    # ここまで

    followings_users_ids = followings_users.pluck(:id)
    followings_users_post_ids = Like.where(user_id: followings_users_ids).pluck(:post_id)
    @follow_like_post = Post.where(id: followings_users_post_ids, created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday)).limit(5)
  end

  def user_likes
    @user = User.find(params[:id])
    @posts = @user.user_likes.includes(:user, :likes, :comments).page(params[:page]).order(created_at: :desc)
  end

  def user_type
    @type_name = params[:type]
    @user = User.find(params[:id])
    @posts = @user.user_type_page(@type_name).page(params[:page]).order(created_at: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :profession, :introduction, :profile_image,:is_valid)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path
    end
  end

end
