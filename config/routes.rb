Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :charges
      resources :users, only: [:index, :create, :update]
      resources :purchases, only: [:index, :create, :update]
      resources :messages, only: [:index, :create, :update]
      post "/charge", to:'charges#create'
    end
  end
end
