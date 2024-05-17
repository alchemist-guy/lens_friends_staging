class Users::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    notification = current_user.notifications
    if notification.present?
      @unread_notification = notification.where(status: false, notification_type: "single")
      @readed_notification = notification.where(status: true, notification_type: "single")
    else
      @unread_notification = nil
      @readed_notification = nil
    end

    if Notification.where(notification_type: "bulk").present?
      @bulk_unread_notification = Notification.where(status: false, notification_type: "bulk")
      @bulk_readed_notification = Notification.where(status: true, notification_type: "bulk")
    else
      @bulk_unread_notification = nil
      @bulk_readed_notification = nil
    end

  end

  def marked_read
    notification = Notification.find_by(id: params[:notification_id])
    notification.update(status: true)
  end

end