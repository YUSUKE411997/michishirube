class Users::RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    current_rooms = UserRoom.select(:room_id).where(user_id: current_user.id)
    @user_rooms = UserRoom.includes(:user).eager_load(room: [:messages]).where(room_id: current_rooms).where.not(user_id: current_user.id).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user, room_id: rooms)

    if user_rooms.nil?
      @room = Room.create
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end
    @messages = @room.messages.includes(:user)
    @message = Message.new(room_id: @room.id)


    @messages.each do |message|
      message.update(checked: true) unless message.user_id == current_user.id
    end
  end

end
