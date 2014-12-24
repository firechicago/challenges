Rails.application.routes.draw do
<<<<<<< HEAD
  resources :questions, only: [:index, :new, :create, :show, :edit, :update]
  resources :answers, only: [:new, :create]
  get '/auth/developer/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
=======
  resources :users, :answers, :questions, only: [ :index, :new, :create, :show, :update, :edit, :destroy ]

  resources :questions do
    resources :answers
  end
  
  get "/auth/:provider/callback" => "sessions#create"

  get "/signout" => "sessions#destroy", :as => :signout

  root to: 'questions#index'
>>>>>>> 6e871fb4e0efaf7d37fd2daf1218c52c13e64a73
end
