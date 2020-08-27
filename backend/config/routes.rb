Rails.application.routes.draw do
  namespace :v1 do
    resources :videos
    resources :bookmarks
    resources :playlists
    resources :search, only: :index
    resources :sessions, only: :create
    delete '/logout', to: 'sessions#destroy'
  end
end
