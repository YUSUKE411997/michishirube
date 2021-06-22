class Users::MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    message = current_user.messages.new(message_params)
    message.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id)
  end
end
