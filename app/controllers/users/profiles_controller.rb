class Users::ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :track_profile_status
    before_action :check_user_profile
  
    def show
      
    end

    def select_category
      
    end

    def set_profile_state
      current_user.update(is_client: params[:is_client], is_creator: params[:is_creator])
      if current_user.is_creator == true 
        redirect_to users_profiles_path
      elsif current_user.is_client == true && !current_user.is_creator
        redirect_to root_path
      end
    end

    def public_view
      @off_days = current_user.off_days
    end

    def edit
    end

    def update
      if current_user.update(user_params)
        check_user_fields
        redirect_to users_profiles_path, notice: 'Profile updated successfully.'
      else
        respond_to do |format|
          format.turbo_stream
        end
      end
    end

    private

    def check_user_profile
      if current_user.is_client?
        redirect_to root_path
      end
    end

    def check_user_fields
      if [current_user.profile_pic, current_user.cover_pic, current_user.first_name, current_user.last_name, current_user.user_name, current_user.state, current_user.DOB, current_user.bio, current_user.business_name].all?(&:present?)
        @track_profile.update(user_data: 20)
      else
        @track_profile.update(user_data: 0)
      end
    end

    def track_profile_status
      @track_profile      = current_user.track_profile
      @progress_bar_count = @track_profile.user_data + @track_profile.profile_status + @track_profile.session_type_data + @track_profile.gallery_data + @track_profile.price_package_data + @track_profile.payment_method_data

      case
      when @track_profile.user_data == 0
        @progress_bar = "Edit Profile"
      when @track_profile.session_type_data == 0
        @progress_bar = "Edit Session"
      when @track_profile.gallery_data == 0
        @progress_bar = "Edit Gallery"
      when @track_profile.price_package_data == 0
        @progress_bar = "Edit Price Package"
      when @track_profile.payment_method_data == 0
        @progress_bar = "Add Payment Method"
      when @progress_bar_count == 100
        @progress_bar = "Your Profile is Complete"
      else
        @progress_bar = "Unknown Status"
      end
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :DOB, :user_name, :business_name,
                                   :state, :bio, :profile_pic, :cover_pic)
    end
end