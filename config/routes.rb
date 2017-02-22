Rails.application.routes.draw do
  resources :markets
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'markets#index'
end
