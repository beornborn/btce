require 'sidekiq/web'

Bo::Application.routes.draw do
  get 'login' => 'user_sessions#new', :as => :login
  post 'auth' => 'user_sessions#create', :as => :auth
  post 'guest_enter' => 'user_sessions#guest_enter', :as => :guest_enter
  delete 'logout' => 'user_sessions#destroy', :as => :logout

  mount Sidekiq::Web, at: "/sidekiq"

  root 'orders#index'

  resources :charts do
    get :data, on: :collection
  end

  resources :indicators do
    get :signals, on: :member
    get :data, on: :member
  end

  resources :trades, only: [:index, :show, :new, :create, :destroy] do
    get :chart, on: :member
    get :continue_chart, on: :member
    get :continue, on: :member
    get :analyze, on: :member
    get :do_trade, on: :member
    get :get, on: :member
    get :last_chart_point, on: :member
    get :last_ichimoku_point, on: :member
    get :profit_rate_by_range, on: :member
    get :trade_results, on: :member
  end

  resources :trade_results do
    get :find, on: :collection
  end

  resources :plans do
    post :generate_billets, on: :member
    delete :cancel_all, on: :member
    delete :delete_not_active, on: :member
  end

  resources :orders do
    delete :cancel_all, on: :collection
    get :new_btce, on: :collection
    post :create_btce, on: :collection
    delete :cancel, on: :member
    post :publish, on: :member
    post :create_derivative, on: :member
    post :store, on: :collection
  end

  resources :users do
    post :toggle_api, on: :collection
  end
end
