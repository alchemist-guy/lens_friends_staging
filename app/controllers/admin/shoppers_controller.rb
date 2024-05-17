class Admin::ShoppersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q       = User.where(is_client: true).ransack(params[:q])
    @shoppers = @q.result(distinct: true)

    @pagy, @shoppers = pagy(@shoppers, items: 10, outset_nav: 2, item_extra: 'mx-2', nav_extra: 'flex justify-center list-none')
  end


end