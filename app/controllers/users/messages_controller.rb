class Users::MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = current_user.messages.new(message_params)
    @message.save
  end

  def destroy
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id)
  end
end
