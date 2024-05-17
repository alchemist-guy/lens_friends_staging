class Users::BillingPortalController < ApplicationController
  before_action :authenticate_user!

  def create
    return_url = success_users_subscription_url(current_user)
    customer_id = current_user.stripe_id

    session = Stripe::BillingPortal::Session.create({
      customer: customer_id,
      return_url: return_url,
    })

    redirect_to session.url, allow_other_host: true

  end


end