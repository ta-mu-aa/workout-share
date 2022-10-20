Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/index'
  get 'posts/show'
  get 'posts/create'
  resources :user

  resources :posts  

  resources :auth_token, only:[:create] do
    post :refresh, on: :collection
    delete :destroy, on: :collection
  end
end
