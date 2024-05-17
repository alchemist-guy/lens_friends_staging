# frozen_string_literal: true

class Auth::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]


  def after_sign_up_path_for(resource)
    stored_location = stored_location_for(resource)

    if stored_location
      stored_location
    elsif resource.is_client
      sellers_path
    elsif resource.is_creator && resource.track_profile.present? && profile_needs_update?(resource.track_profile)
      users_profiles_path # Replace with the actual path you want to redirect to
    else
      root_path
    end
  end

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, 
                                      :password_confirmation, :is_client, 
                                      :is_creator, :user_name, :first_name, 
                                      :last_name, :phone_no, :discolure,
                                      :state, :DOB])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def profile_needs_update?(track_profile)
    track_profile.user_data == 0 || track_profile.session_type_data == 0 ||
      track_profile.gallery_data == 0 || track_profile.price_package_data == 0
    # Add more conditions if needed
  end

end
