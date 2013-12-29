TaskfishmvpA::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  namespace :api do
    namespace :v1 do

      post 'users/create' => 'user#create'

      get 'users/:user_id/events' => 'event#index'
      get 'users/:user_id/events/:event_id' => 'event#show'
      delete 'users/:user_id/events/:event_id' => 'event#remove'
      post 'users/:user_id/events/create' => 'event#create'
      post 'users/:user_id/events/:event_id/invite' => 'event#invite'
      get '/users/:user_id/events/:event_id/posts/:post_id' => 'event#post'
      get 'users/:user_id/events/:event_id/stats' => 'event#stats'

      post 'users/:user_id/events/:event_id/comment' => 'comment#create_event_comment'
      get 'users/:user_id/events/:event_id/comments' => 'comment#get_event_comments'
      post 'users/:user_id/events/:event_id/pictures/:picture_id/comment' => 'comment#create_picture_comment'
      get 'users/:user_id/events/:event_id/pictures/:picture_id/comments' => 'comment#get_picture_comment'

      post 'users/:user_id/events/:event_id/pictures/create' => 'picture#create'
      get 'users/:user_id/events/:event_id/pictures' => 'picture#index'
      get 'users/:user_id/events/:event_id/pictures/:picture_id' => 'picture#show'
      delete 'users/:user_id/events/:event_id/pictures/:picture_id' => 'picture#remove'
      get 'users/:user_id/events/:event_id/posts/:post_id/like' => 'picture#like'
      get 'users/:user_id/events/:event_id/posts/:post_id/comment' => 'picture#comment'

      get 'users/:user_id/events/:event_id/like' => 'like#like_event'
      get 'users/:user_id/events/:event_id/likes' => 'like#event_likes'

    end
  end


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
