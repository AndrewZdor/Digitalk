ActionController::Routing::Routes.draw do |map|

  map.with_options :controller=>'mrcs' do |m|
      m.edit_mrc_form 'mrcs/edit_mrc_form' ,:action=>'edit_mrc_form'
  end

  map.with_options :controller=>'users' do |u|
    u.load_user_form 'users/load_user_form' ,:action=>'load_user_form'
    u.edit_user_form 'users/edit_user_form' ,:action=>'edit_user_form'
    u.set_children 'users/set_children' ,:action=>'set_children'
    u.filter_children 'users/filter_children' ,:action=>'filter_children'
    u.get_project_users 'users/get_project_users' ,:action=>'get_project_users'
  end
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.dashboard '/dashboard', :controller => 'site', :action => 'dashboard'
  
  map.resources :surveys
  map.resources :blogs
  map.resources :projects
  map.resources :clients
  map.resources :mrcs
	map.resources :users
  map.resource :session

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "sessions",:action=>'new'
  
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
