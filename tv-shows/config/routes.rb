TvShows::Application.routes.draw do
  resources :television_shows, only: [:index, :show, :new, :create] do
    resources :characters, only: [:new, :create]
  end
end
