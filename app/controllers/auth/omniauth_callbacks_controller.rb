# frozen_string_literal: true

class Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def google_oauth2

    user = User.from_omniauth(auth)
    if user.present?
      sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect user, event: :authentication
    else
      flash[:alert] =
        t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
  end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  def passthru
    super
  end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  protected

  def after_omniauth_failure_path_for(_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    # stored_location_for(resource_or_scope) || root_path
    stored_location = stored_location_for(resource_or_scope)

    if stored_location
      stored_location
    else
      if resource_or_scope.is_client.present? || resource_or_scope.is_creator.present?
        if resource_or_scope.is_creator.present? && profile_needs_update?(resource_or_scope.track_profile)
          users_profiles_path
        else
          root_path
        end
      else
        select_category_users_profiles_path
      end
    end
    

       
    # if stored_location
    #   stored_location
    # elsif profile_needs_update?(resource_or_scope.track_profile)
    #   users_profiles_path # Replace with the actual path you want to redirect to
    # else
    #   root_path
    # end
  end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  private 

  def profile_needs_update?(track_profile)
    track_profile.user_data == 0 || track_profile.session_type_data == 0 ||
      track_profile.gallery_data == 0 || track_profile.price_package_data == 0
    # Add more conditions if needed
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end
