class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :whithdraw, :destroy_confirm]
  before_action :ensure_normal_user, only: [:edit, :destroy_confirm, :withdraw]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:comments, :likes).page(params[:page]).order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
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
      redirect_to root_path, notice: "他のユーザーの編集は行えません"
    end
  end

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      redirect_to root_path, notice: 'ゲストユーザーはプロフィール編集と退会はできません'
    end
  end

end
