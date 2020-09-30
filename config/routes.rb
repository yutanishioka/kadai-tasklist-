Rails.application.routes.draw do
  get 'toppages/index'
    root to: 'toppages#index'
    get 'users/index'
    get 'users/show'
    get 'users/new'
    get 'users/create'
    root to: "tasks#index"
    
    get "signup", to: "users#new"
    resources :tasks
end
