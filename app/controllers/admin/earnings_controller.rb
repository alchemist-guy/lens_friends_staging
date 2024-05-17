class Admin::EarningsController < ApplicationController
  before_action :authenticate_admin!

  def index
  end

end