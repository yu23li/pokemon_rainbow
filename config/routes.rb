Rails.application.routes.draw do
  resources :pokedexes
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
