# frozen_string_literal: true

class Auth::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.provider == 'google_oauth2'
      # If the user signed up with Google, inform them to use Google sign-in
      flash[:alert] = "Oops! Since you signed up with Google, please use the Google sign-in option to proceed."
      redirect_to request.referer
    else
      super
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    # stored_location_for(resource_or_scope) || root_path
    stored_location = stored_location_for(resource_or_scope)

    if stored_location
      stored_location
    elsif resource_or_scope.is_client
      sellers_path
    elsif resource_or_scope.is_creator && resource_or_scope.track_profile.present? && profile_needs_update?(resource_or_scope.track_profile)
      users_profiles_path # Replace with the actual path you want to redirect to
    else
      root_path
    end

  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def profile_needs_update?(track_profile)
    track_profile.user_data == 0 || track_profile.session_type_data == 0 ||
      track_profile.gallery_data == 0 || track_profile.price_package_data == 0
    # Add more conditions if needed
  end

end
