Stratevarius3::Application.routes.draw do

# Route of my home page, the index.html.erb page of my app/views/home folder
  root 'home#index'

# lets us use /home as a shortcut to always be able to easily get back to my home page, called as "home_path"
  get 'home/' => 'home#index', as: :home

# lets us use /signup as a shortcut to always be able to easily get back a page where a new user can sign up for the site
  get 'signup', to: 'executives#new', as: :signup

# lets us use /signin as a shortcut to always be able to easily get back a page where an EXISTING user can login to the site upon return.  Points to sessions => new because they have to be authorized using their credentials before they can proceed to act on the site as a current_user.  
  get 'signin', to: 'sessions#new', as: :signin

# lets us use /signout as a shortcut to always be able to easily logout of the site and end the current user session.  should elegantly put them back to ???? location after they logout?
  get 'signout', to: 'sessions#destroy', as: :signout

# sets up the entire suite of standard restful routes for the resources controller to then process when the user goes to /relationships/x
  resources :relationships

# sets up the entire suite of standard restful routes for the resources controller to then process when the user goes to /sessions/some_defined_action_here
  resources :sessions

# manually writte-out collection of full standard restful routes for the executives_controller to then process when the user goes to /executives/some_defined_action_here
  get 'executives/' => 'executives#index', as: :executives
  get 'executives/new' => 'executives#new', as: :new_executive
  get 'executives/:id' => 'executives#show', as: :executive
  post 'executives/' => 'executives#create', as: :create_executive
  get 'executives/:id/edit' => 'executives#edit', as: :edit_executive
  patch 'executives/:id' => 'executives#update', as: :update_executive
  delete 'executives/:id' => 'executives#destroy', as: :delete_executive

# manually writte-out collection of full standard restful routes for the executives_controller to then process when the user goes to /organizations/some_defined_action_here
  get 'organizations/' => 'organizations#index', as: :organizations
  get 'organizations/new' => 'organizations#new', as: :new_organization
  get 'organizations/:id' => 'organizations#show', as: :organization
  post 'organizations/' => 'organizations#create', as: :create_organization
  get 'organizations/:id/edit' => 'organizations#edit', as: :edit_organization
  patch 'organizations/:id' => 'organizations#update', as: :update_organization
  delete 'organizations/:id' => 'organizations#destroy', as: :delete_organization

<<<<<<< HEAD
  get '/deals.xml' => 'deals#index', :as => :deals_xml, :format => 'xml'
  get '/deals' => 'deals#index', :as => :deals

  resources :deals do
      collection do
        get :accepted
        get :pending
        get :denied
      end
  end

    get '/signup/:inviter_id/:inviter_code' => 'executives#new', :as => :signup_by_id

=======
>>>>>>> master
# if you see a "do", it needs an "end"  :-)
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

