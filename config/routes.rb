Rails.application.routes.draw do

  root to: 'person#index'
  get '/search' => 'person#search'
  get '/show' => 'person#show'
  get '/search_season' => 'person#search_season'
  get '/search_episode' => 'person#search_episode'
  get '/show_episode' => 'person#show_episode'
  get '/show_char' => 'person#show_char'
  get '/person/:id', to: 'person#show', as: 'person'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
