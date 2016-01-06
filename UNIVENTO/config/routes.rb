Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  get 'category/index'

  mount Ckeditor::Engine => '/ckeditor'
  get 'homepage/index'

  root 'homepage#index'

  resources :user do
    resources :normal
    get 'preferences', :on => :collection
    post 'savePreferences', :on => :collection
    post 'requestfriend', :on => :collection
    post 'acceptfriend', :on => :collection
    post 'rejectfriend', :on => :collection
    post 'cancelfriend', :on => :collection
    post 'deletefriend', :on => :collection
    post 'search', :on => :collection
    get 'search', :on => :collection

  end

  resources :event do 
    post 'search', :on => :collection
    post 'accept', :on => :collection
    get 'registration'
  end
  get '/advanced_search_form', to: 'event#advanced_search_form'
  get '/advanced_search', to: 'event#advanced_search'

  resources :promoter

  resources :colaborator
  resources :category
  resources :registration

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :users do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_session
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
end
