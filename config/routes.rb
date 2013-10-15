LaunchNDine::Application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'launch/registrations' }

  resources :users, only: [:show] do
    resources :locations,   only: [:new, :create, :update]
    resources :restaurants, only: [:new, :create]
    resources :orders,      only: [:index]
  end

  resources :locations, only: [:show, :edit, :index, :destroy]

  resources :restaurants, except: [:new, :create] do
    resources :menus,     only: [:new, :create, :index, :update]
    resources :orders,    only: [:index]
  end

  resources :menus, only: [:show, :edit, :update, :destroy] do
    resources :menu_items, only: [:index, :create]
    resources :orders,     only: [:new, :create]
  end

  resources :menu_items, only: [:edit, :update, :destroy]

  resources :orders, only: [:show, :index, :update]

  root 'pages#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
