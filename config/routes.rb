Rails.application.routes.draw do
  devise_for :users

  resources :user_stocks, only: [:create, :destroy]

  get 'my_portfolio', to: "users#my_portfolio"
  get 'search_stocks', to: 'stocks#search'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
