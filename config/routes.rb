Rails.application.routes.draw do
  root 'pages#index'

  resources :questions do
    resources :answers, only: %i[create edit update destroy]
    resources :comments, only: %i[new create edit update destroy]
  end

end
