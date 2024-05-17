class SellersController < ApplicationController
  before_action :set_sellers, only: %i[show]

  def index

    selected_session_type = params.dig(:q, :session_type_eq)&.first&.downcase

    if selected_session_type.present?
      @q = User.joins(:track_profile, :session_type).where(is_creator: true, track_profiles: { user_data: 20, session_type_data: 20, gallery_data: 10, payment_method_data: 20 }, session_types: { "#{selected_session_type}" => true } ).ransack(params[:q])
    else
      # If no session types are selected, use the original query without modification
      @q = User.joins(:track_profile, :session_type).where(is_creator: true, track_profiles: { user_data: 20, session_type_data: 20, gallery_data: 10, payment_method_data: 20 } ).ransack(params[:q])
    end

    @sellers = @q.result(distinct: true)
    if @sellers.count == 0
      @random_sellers =  User.joins(:track_profile, :session_type).where(is_creator: true, track_profiles: { user_data: 20, session_type_data: 20, gallery_data: 10, payment_method_data: 20 } ).order(Arel.sql('RANDOM()')).limit(10)
    end

    off_days_start_date = params.dig(:q, :off_days_start_date_eq)

    if off_days_start_date.present?

    end

    @pagy, @sellers = pagy(@sellers, items: 15, outset_nav: 2, item_extra: 'mx-2', nav_extra: 'flex justify-center list-none')

  end

  def show
    @off_days = @seller.off_days
  end

  private

  def set_sellers
    @seller = User.find(params[:id])
  end

end