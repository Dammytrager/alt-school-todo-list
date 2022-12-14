Rails.application.routes.draw do
  resources :todos

  scope :auth do
    get 'sign-in', to: 'auth#sign_in', as: :sign_in
    post 'sign-in', to: 'auth#login', as: :login
    get 'sign-up', to: 'auth#sign_up', as: :sign_up
    post 'sign-up', to: 'auth#create_user', as: :create_user
    post 'logout', to: 'auth#logout', as: :logout
  end

  namespace :api do
    get 'test', to: 'test#index', as: :test
    post 'users', to: 'auth#register', as: :register
    post 'sign-in', to: 'auth#sign_in', as: :sign_in

    resources :todos, only: [:index, :create, :update, :destroy]
    # get 'todos', to: 'todos#index', as: :api_todos_path
    # post 'todos', to: 'todos#create', as: :api_todos_create_path
    # put 'todos/:id', to: 'todos#update', as: :api_todos_path
    # patch 'todos/:id', to: 'todos#update', as: :api_todos_path
    # destroy 'todos/:id', to: 'todos#destroy', as: :api_todos_path
  end

  root 'pages#home'
end
