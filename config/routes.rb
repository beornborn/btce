require 'sidekiq/web'

Bo::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  mount Sidekiq::Web, at: "/sidekiq"
  # You can have the root of your site routed with "root"
  root 'orders#index'

  resources :common
  get '/chart' => 'common#chart'
  get '/chart/signals' => 'common#signals'
  get '/ichimoku' => 'common#ichimoku'

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

  resources :minutes, only: []
  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
