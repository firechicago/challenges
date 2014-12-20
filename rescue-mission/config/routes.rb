Rails.application.routes.draw do
  resources :questions, only: [:index, :new, :create, :show, :edit, :update]
  resources :answers, only: [:new, :create]
  get '/auth/developer/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
end
