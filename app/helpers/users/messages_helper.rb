module Users::MessagesHelper

  def messages_false_count
    current_room_ids = current_user.user_rooms.pluck(:room_id)
    Message.where(room_id: current_room_ids, checked: false).where.not(user_id: current_user.id).count
  end
end