class Users::AccountsController < ApplicationController
    before_action :authenticate_user!

    def switch_account
      current_user.update(is_creator: true, is_client: true) if current_user.is_creator.nil? || current_user.is_client.nil?

      if current_user.activate_creator == nil || current_user.activate_creator == false
        current_user.update(activate_creator: true)
      else
        current_user.update(activate_creator: false)
      end

      respond_to do |format|
        format.turbo_stream
      end

    end

    private

    def user_params
      params.require(:user).permit(:activate_creator)
    end
end