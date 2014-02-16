require 'sidekiq/web'

Bo::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  mount Sidekiq::Web, at: "/sidekiq"
  # You can have the root of your site routed with "root"
  root 'common#index'
  get '/chart' => 'common#chart'
  get '/chart/point_details' => 'common#point_details'
  get '/chart/signals' => 'common#signals'
  get '/ichimoku' => 'common#ichimoku'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :trades, only: [:index, :show, :new, :create, :destroy] do
    get :chart, on: :member
    get :continue_chart, on: :member
    get :continue, on: :member
    get :do_trade, on: :member
    get :get, on: :member
    get :last_chart_point, on: :member
    get :last_ichimoku_point, on: :member
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
