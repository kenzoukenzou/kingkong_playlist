Rails.application.routes.draw do
  namespace :v1 do
    resources :videos
    resources :bookmarks
    resources :playlists
    resources :search, only: :index
    resources :sessions, only: %i[create destroy]
  end
end
