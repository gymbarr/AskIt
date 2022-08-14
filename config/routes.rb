Rails.application.routes.draw do
  root 'pages#index'

  resources :questions do
    resources :answers, only: %i[create update destroy]
  end

end
