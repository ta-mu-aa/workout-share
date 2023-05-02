Rails.application.routes.draw do
  get 'health_check', to: 'health_check#index'
  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end
  get 'posts/individual_post/:id', to: 'posts#individual_post'
  
  resources :user, only:[:create, :index, :show, :edit, :update] do 
    member do
      get :relationship_list
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :posts  

  resources :auth_token, only:[:create] do
    post :refresh, on: :collection
    delete :destroy, on: :collection
  end
end
