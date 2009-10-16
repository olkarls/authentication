ActionController::Routing::Routes.draw do |map|
  map.signup  "signup", :controller => "users", :action => "new"
  map.login   "login",  :controller => "user_sessions", :action => "new"
  map.logout  "logout", :controller => "user_sessions", :action => "destroy"
  
  map.namespace(:admin) do |admin|
     admin.resources :users, :member => { :confirm_destruction => :get }
  end

  map.resources :user_sessions, :only => [:new, :create, :destroy]
  map.resources :users, :only => [:new, :create, :edit, :update]
  map.resources :password_resets, :only => [:new, :create, :edit, :update]
end