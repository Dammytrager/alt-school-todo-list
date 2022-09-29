Rails.application.routes.draw do
  resources :todos

  root 'pages#hello'
end
