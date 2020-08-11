Rails.application.routes.draw do
  namespace :v1 do
    resources :videos
    resources :bookmarks
    resources :playlists
  end
end
