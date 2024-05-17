Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions: 'admin_auth/sessions',
    registrations: 'admin_auth/registrations'
  }
  devise_for :users, controllers: {
    registrations: 'auth/registrations',
    sessions: 'auth/sessions',
    omniauth_callbacks: 'auth/omniauth_callbacks'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_scope :user do
      get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_scope :admin do
    get '/admin/sign_out' => 'admin_auth/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    resources :home
    resources :sellers
    resources :shoppers
    resources :earnings
    resources :notifications do
      post :bulk
    end
    resources :emails do
      post :bulk_seller
      post :bulk_shopper
    end
  end

  authenticated :admin do
    root to: 'admin/home#index', as: :admin_root
  end

  resources :sellers
  resources :faq, only: [:index]
  resources :professionals, only: [:index]
  resources :communications do 
    member do
      post :book_request
    end
  end

  namespace :users do
    resources :notifications do 
      post :marked_read
    end
    resource :profiles do
      get :public_view
      get :select_category
      post :set_profile_state
    end
    resources :settings do
      member do
        patch :personal_info
        patch :change_password
        post :contact_support
        post :delete_account
      end
    end
    resource :calendars
    resources :off_days
    resources :session_types
    resources :packages
    resources :subscriptions do
      member do
        post :checkout
        get  :success
        get  :cancel
        get  :dashboard
      end
    end
    resources :billing_portal
    resources :gallery do
      member do
        delete :remove_image
        delete :remove_video
      end
      resources :attachments, only: :index
    end
    resource :accounts do
      patch 'switch_account', on: :member
    end
  end

  # Defines the root path route ("/")
  root "posts#index"
end
