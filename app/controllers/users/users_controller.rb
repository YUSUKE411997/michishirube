class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :whithdraw]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).order(created_at: :desc)
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
    followings_users = current_user.followings
    @posts = Post.where(user_id: followings_users).page(params[:page]).order(created_at: :desc)
  end

  def user_likes
    @user = User.find(params[:id])
    @likes = @user.user_likes.page(params[:page]).order(created_at: :desc)
  end

  def user_type
    @type_name = params[:type]
    @user = User.find(params[:id])
    case @type_name
      when "気ままに"
        @posts = @user.posts.where(type: 0).page(params[:page]).order(created_at: :desc)
      when "やってみたい"
        @posts = @user.posts.where(type: 1).page(params[:page]).order(created_at: :desc)
      when "やってみた"
        @posts = @user.posts.where(type: 2).page(params[:page]).order(created_at: :desc)
    end
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
