Ggame::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
   
  get 'logged/:id' => 'logged#show'
  
  # You can have the root of your site routed with "root"
  root 'welcome#index'
  
  # Example of regular route:
  get 'user/:id' => 'user#show'
  post 'logged/:id/create' => 'logged#create'
  post 'logged/:id/cancel' => 'logged#cancel'
  post 'logged/:id/join' => 'logged#join'
  get  'logged/:id/state' => 'logged#state'
  post  'logged/:id/cancel_waiting' => 'logged#cancel_waiting'
  post  'logged/:id/accept_player' => 'logged#accept_player'
  post  'logged/:id/reject_player' => 'logged#reject_player'


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
