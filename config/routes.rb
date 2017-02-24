Rails.application.routes.draw do
  resources :markets do
    resources :market_tags
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'markets#index'
end
