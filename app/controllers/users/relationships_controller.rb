class Users::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    @user = User.find_by(id: follow.follower_id)
    @user.create_notification_follow!(current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    @user = User.find_by(id: follow.follower_id)
    follow.destroy
    redirect_back(fallback_location: root_path)
  end
end
