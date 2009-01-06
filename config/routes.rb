ActionController::Routing::Routes.draw do |map|
  map.channel '/channels/:channel.:format', :controller => 'stories', :action => 'index'
  map.category '/categories/:category.format', :controller => 'stories', :action => 'index'
  map.tag '/tags/:tag.format', :controller => 'stories', :action => 'index'  
  map.channel_category_tag '/channels/:channel/:category/:tag.:format', :controller => 'stories', :action => 'index'
  
  map.channel '/channels/:channel', :controller => 'stories', :action => 'index'
  map.category '/categories/:category', :controller => 'stories', :action => 'index'
  map.tag '/tags/:tag', :controller => 'stories', :action => 'index'  
  map.channel_category_tag '/channels/:channel/:category/:tag', :controller => 'stories', :action => 'index'

  map.resources :comments
  
  map.resources :diggs
  
  map.resources :stories
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users do |user|
    user.resource :profile
  end

  map.resource :session, :member => {:select_language => :put}
  
  map.namespace(:admin) do |admin|
    admin.resources :categories
    admin.resources :channels
    admin.resources :stories
    admin.resources :comments    
    admin.resources :moderated_stories    
    
    admin.resources :users
    
    admin.resources :sites
    admin.resources :translations, :collection => {:translated => :get, :untranslated => :get, :export => :get, :import => :get}
    admin.resources :site_languages
    admin.resources :site_links
  end
  
  map.admin '/admin', :controller => 'admin/sites', :action => 'index'

  map.root :controller => 'stories'
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
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect '*path', :controller => 'application', :action => 'rescue_404'
end
