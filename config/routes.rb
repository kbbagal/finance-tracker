Rails.application.routes.draw do
  resources :user_stocks
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'stock', to: 'stocks#stock'
  root 'welcome#index'
  devise_for :users
  get 'friends', to: 'users#my_friends'
end
