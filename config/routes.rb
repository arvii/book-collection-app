Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  get 'books/index'
  resources :books, only: [:index]
end
