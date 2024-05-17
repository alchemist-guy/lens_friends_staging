class Users::SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def personal_info
    if current_user.update(user_params)
      redirect_to users_settings_path, notice: 'Profile updated successfully.'
    else
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def change_password
    if current_user.update_with_password(password_params)
      redirect_to users_settings_path, notice: "Password successfully updated."
    else
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def contact_support
    sender_email = current_user.email
    receiver_email = "hello@lensfriendsapp.com"
    email_subject = 'LensFriends Shopper'
    email_body = 'Body of the email'

    subject_param = CGI.escape(email_subject)
    body_param = CGI.escape(email_body)

    mailto_link = "mailto:#{receiver_email}?subject=#{subject_param}&body=#{body_param}&from=#{sender_email}"

    redirect_to mailto_link, allow_other_host: true
  end

  def delete_account

    current_user.destroy
    redirect_to root_path

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :DOB, :user_name, :business_name,
                                 :state, :bio, :profile_pic, :cover_pic)
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

end