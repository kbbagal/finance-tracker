Rails.application.routes.draw do
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'stock', to: 'stocks#stock'
  root 'welcome#index'
  devise_for :users
end
