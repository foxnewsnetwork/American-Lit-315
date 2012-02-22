Adserver::Application.routes.draw do
 
  # Pages  
  match "/index", :to => "pages#index"
  match "/misc", :to => "pages#misc"
  match "/about", :to => "pages#about"
  match "/contact", :to => "pages#contact"
  match "/contact", :to => "pages#contact"

  devise_for :publishers
  resources :payments

  # Matches new_token url for platforms/publishers to create tokens for API calls
  # This route can be invoked with new_token_url(:id => current_publisher.id)
  match 'publishers/:id/new_token' => 'publishers#new_token', :as => :new_token

	resources :publishers, :only => [:new, :show, :index, :new_token] do
		resources :games
	end

  # Matches new_token url for games to create tokens for API calls
  # This route can be invoked with new_game_token_url(:publisher_id => current_publisher.id, :game_id => game.id)
  match 'publishers/:publisher_id/games/:game_id/new_token' => 'games#new_token', :as => :new_game_token

  devise_for :companies
 # resources :ads, :only => [:index]
  resources :companies, :only => [:new, :show, :index] do
  	resources :products
  	resources :coupons  # name space to change url 
  	resources :ads do
      post 'api_login', :on => :collection
    end
  end

  resources :ads, :only => [:api_login] do
      post 'api_login', :on => :collection
  end

  devise_for :users
  resources :users, :only => [:new, :show, :index] do
  	resources :payments
    post 'api_login', :on => :collection
  end

  ######## region API use #########
  # Separated environment used for Pacman's TESTING
  # fixed the style problem that was causing cancer
  # go to home.com/api/coupon.xml to see result
  match "/api/v1/coupon", :to => "coupons#update_coupon_api", :via=>:put #only put method
  match "/api/v1/coupon", :to => "coupons#random_api"

  match "/api/v1/product", :to => "products#update_product_api", :via=>:put #only put method
  match "/api/v1/product", :to => "products#random_api"

  match "/api/v1/user_email_form", :to => "tmp_users#show" #display submit form 
  match "/api/v1/user_email_form/create", :to => "tmp_users#create" #display submit form 
  match "/api/v1/user_email_form/success", :to => "tmp_users#success" #display submit form 
  match "/api/v1/user_email_form/failure", :to => "tmp_users#failure" #display submit form
  match "/api/v1/user_email_form/redeemed_to_soon", :to => "tmp_users#redeemed_to_soon" #display submit form

  match "/api/vi/user_login", :to => "users#api_login"

  match "/api/v1/user", :to => "tmp_users#create", :via=>:post #post email, coupon_id, token

  match "/api/v1/product_inventory_display", :to => "products#inventory_display" #display submit form 

  match "/api/coupon/show", :to => "coupons#show"
  resources :coupons

  #################################

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "pages#home"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
