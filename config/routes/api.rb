namespace :api, defaults: { format: :json } do
  namespace :slack do
    namespace :slash do
      resources :countdown, only: [:create]
      resources :pokedex, only: [:create]
    end
  end
end
