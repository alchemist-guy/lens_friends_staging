class Users::SubscriptionsController < ApplicationController
    before_action :authenticate_user!

    def index
      if current_user.subscription_status == nil || current_user.subscription_status == "inactive"
        @monthly_plan = Plan.find_by(interval: "month")
        @yearly_plan  = Plan.find_by(interval: "year")
      else
        redirect_to dashboard_users_subscription_path(current_user)
      end
    end

    def dashboard

    end
  
    def show
    end

    def checkout
      price_id = params[:priceId]
      user_state = current_user.state

      # tax_rate_id = fetch_tax_rate_for_state(user_state)

      session = Stripe::Checkout::Session.create({
        customer: current_user.stripe_id,
        success_url: success_users_subscription_url,
        cancel_url: cancel_users_subscription_url,
        mode: 'subscription',
        line_items: [{
          # For metered billing, do not pass quantity
          quantity: 1,
          price: price_id,
        }],
        allow_promotion_codes: true,
        automatic_tax: {
          enabled: true,
        },
        customer_update: {
          address: 'auto',  # or set 'shipping' to 'auto' if applicable
        },
      })

      redirect_to session.url, allow_other_host: true

    end

    def success
      customer_id = current_user.stripe_id
      subscription = Stripe::Subscription.list(customer: customer_id).data.first
      if subscription.status == 'active'
        current_user.update(subscription_status: subscription.status, subscription_ends_at: Time.at(subscription.current_period_end).to_datetime, plan: subscription.plan.interval)
        # flash[:notice] = "Successfully subscribed!"
      else
        # flash[:alert] = "Subscription status not recognized."
      end
      current_user.active?
      current_user.save
      current_user.update(is_creator: true) if current_user.is_creator == nil || current_user.is_creator == false
      check_payment_method_field
      redirect_to users_profiles_path
    end

    def cancel
      # flash[:notice] = "fail"
      redirect_to users_subscriptions_path
    end

    def create

    end

    def update
    end

    def check_payment_method_field
      @track_profile       = current_user.track_profile
      @subscription_status = current_user.subscription_status
      if @subscription_status == "active"
        @track_profile.update(payment_method_data: 20)
      else
        @track_profile.update(payment_method_data: 0)
      end
    end
  
  end