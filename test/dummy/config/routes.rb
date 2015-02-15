Rails.application.routes.draw do
  root 'cars#index'

  get 'cars', to: 'cars#index', as: :cars
  get 'cars/:id', to: 'cars#show', as: :car

end
