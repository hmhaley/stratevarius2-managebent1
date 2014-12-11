Stratevarius3::Application.routes.draw do

  # Route of my home page
  root 'home#index'

  get 'signup', to: 'executives#new', as: :signup
  get 'signin', to: 'sessions#new', as: :signin
  get 'signout', to: 'sessions#destroy', as: :signout

  resources :relationships

  resources :sessions

  get 'home/' => 'home#index', as: :home

  get 'executives/' => 'executives#index', as: :executives
  get 'executives/new' => 'executives#new', as: :new_executive
  get 'executives/:id' => 'executives#show', as: :executive
  post 'executives/' => 'executives#create', as: :create_executive
  get 'executives/:id/edit' => 'executives#edit', as: :edit_executive
  patch 'executives/:id' => 'executives#update', as: :update_executive
  delete 'executives/:id' => 'executives#destroy', as: :delete_executive

  get 'organizations/' => 'organizations#index', as: :organizations
  get 'organizations/new' => 'organizations#new', as: :new_organization
  get 'organizations/:id' => 'organizations#show', as: :organization
  post 'organizations/' => 'organizations#create', as: :create_organization
  get 'organizations/:id/edit' => 'organizations#edit', as: :edit_organization
  patch 'organizations/:id' => 'organizations#update', as: :update_organization
  delete 'organizations/:id' => 'organizations#destroy', as: :delete_organization

end

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

