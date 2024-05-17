class Admin::SellersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_sellers, only: %i[show]

  def index
    @q       = User.where(is_creator: true).ransack(params[:q])
    @sellers = @q.result(distinct: true)

    @pagy, @sellers = pagy(@sellers, items: 10, outset_nav: 2, item_extra: 'mx-2', nav_extra: 'flex justify-center list-none')

  end

  def show
    @off_days = @seller.off_days
  end

  private

  def set_sellers
    @seller = User.find(params[:id])
  end

end