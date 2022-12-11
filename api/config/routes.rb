Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/index'
  get 'posts/show'
  get 'posts/create'
  resources :user, only:[:create, :index, :show, :edit, :update] do 
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :posts  

  resources :auth_token, only:[:create] do
    post :refresh, on: :collection
    delete :destroy, on: :collection
  end
end
