Rails.application.routes.draw do
  resources :pokemon_battles do
    post 'attack', on: :member
    get 'surrender', on: :member
  end
  resources :pokemon_skills
  resources :pokemons
  resources :skills
  resources :pokedexes
  resources :pokemon_battle_logs
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
