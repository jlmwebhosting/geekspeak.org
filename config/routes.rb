BetaGeekspeakOrg::Application.routes.draw do
  

  resources :users

#  resources :segment_bits

 # resources :bits


  resources :episodes, :id => /[0-9]+\/[0-9]+\/[0-9]+/ do
    
    resources :segments do
        resources :bits
    end
    resources :participants
  end
  
  match "/episodes/:year/" => "episodes#year_archive", 
               :constraints => {:year => /\d{4}/ }
  match "/episodes/:year/:month/" => "episodes#month_archive", 
               :constraints => {:year => /\d{4}/, :month => /0[1-9]|1[0-2]/ }
               
               
  devise_for :users, ActiveAdmin::Devise.config
  
  ActiveAdmin.routes(self)
  
  
  get '/admin/episodes/:id', :controller => "admin/episodes",
      :action => 'show', :id => /[0-9]+\/[0-9]+\/[0-9]+/
  get '/admin/episodes/:id/edit', :controller => "admin/episodes",
          :action => 'edit', :id => /[0-9]+\/[0-9]+\/[0-9]+/
  put '/admin/episodes/:id', :controller => "admin/episodes",
              :action => 'update', :id => /[0-9]+\/[0-9]+\/[0-9]+/
  delete '/admin/episodes/:id', :controller => "admin/episodes",
              :action => 'destroy', :id => /[0-9]+\/[0-9]+\/[0-9]+/
  
  
 # mount Refinery::Core::Engine => '/engin/refinery.geekspeak.org/'
  
  
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
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
