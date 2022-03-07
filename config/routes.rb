Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :transactions, only: [:create, :index]

  resources :merchants, only: [:index, :edit, :update, :destroy]
end

