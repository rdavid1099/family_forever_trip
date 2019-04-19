namespace :api, defaults: { format: :json } do
  namespace :slack do
    namespace :slash do
      post 'countdown', to: 'commands#countdown'
    end
  end
end
