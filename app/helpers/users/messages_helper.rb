module Users::MessagesHelper

  def messages_false_count
    current_rooms = UserRoom.select(:room_id).where(user_id: current_user.id)
    Message.where(room_id: current_rooms, checked: false).where.not(user_id: current_user.id).count
  end
end