Rails.application.routes.draw do
  devise_for :users

  get 'my_portfolio', to: "users#my_portfolio"
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
