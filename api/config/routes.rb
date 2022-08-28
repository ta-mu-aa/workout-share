Rails.application.routes.draw do
  resources :user

  resources :auth_token, only:[:create] do
    post :refresh, on: :collection
    delete :destroy, on: :collection
  end
end
