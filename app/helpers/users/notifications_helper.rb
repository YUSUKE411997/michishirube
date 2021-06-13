module Users::NotificationsHelper

  def unchecked_notifications
    current_user.passive_notifications.where(checked: false)
  end

  def unchecked_count
    current_user.passive_notifications.where(checked: false).count
  end
end
