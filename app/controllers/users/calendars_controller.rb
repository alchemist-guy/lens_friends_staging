class Users::CalendarsController < ApplicationController
  before_action :authenticate_user!

  def show
    @off_days = current_user.off_days

    # start_date = Date.today.to_date
    # @off_days = OffDay.where(start_date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end

end