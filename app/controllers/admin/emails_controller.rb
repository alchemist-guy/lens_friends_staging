class Admin::EmailsController < ApplicationController
  before_action :authenticate_admin!
  # before_action :set_notification, only: %i[ show edit update destroy]

  def index
  end

  def bulk_shopper
    shopper_emails = User.where(is_client: true).pluck(:email)
    subject = params[:topic]
    body    = params[:message]

    shopper_emails.each do |email|
      BulkShopperMailer.send_email_to_shopper(email, subject, body).deliver_now
    end

    redirect_to admin_emails_path, notice: "Successfully sent email to shoppers."

  end

  def bulk_seller
    seller_emails = User.where(is_creator: true).pluck(:email)
    subject = params[:topic]
    body    = params[:message]

    seller_emails.each do |email|
      BulkSellerMailer.send_email_to_seller(email, subject, body).deliver_now
    end
    redirect_to admin_emails_path, notice: "Successfully sent email to Professionals."
  end
  
end