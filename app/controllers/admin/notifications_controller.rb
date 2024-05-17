class Admin::NotificationsController < ApplicationController
  before_action :authenticate_admin!
  # before_action :set_notification, only: %i[ show edit update destroy]

  def index
  end

  def create
    user = User.find_by(email: params[:notification][:user_email])

    if user.present?
      notification = Notification.new(admin_id: current_admin.id, user_id: user.id, message: params[:notification][:message], notification_type: "single", status: false, topic: params[:notification][:topic])
    end

    respond_to do |format|
      if notification&.save
        format.html { redirect_to admin_notifications_path, notice: "Notification is successfully sent." }
      else
        format.turbo_stream
        # Handle the case where notification couldn't be saved
      end
    end

  end

  def bulk

    notification = Notification.new(admin_id: current_admin.id, user_id: User.first.id, message: params[:notification][:message], notification_type: "bulk", status: false, topic: params[:notification][:topic])


    respond_to do |format|
      if notification&.save
        format.html { redirect_to admin_notifications_path, notice: "Bulk Notification is successfully sent." }
      else
        format.turbo_stream
        # Handle the case where notification couldn't be saved
      end
    end


  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_notification
    @notification = Notification.find(params[:id])
  end

end