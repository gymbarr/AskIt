Rails.application.routes.draw do
  root 'pages#index'

  resources :users, only: %i[new create]
  resource :session, only: %i[new create destroy]

  resources :questions do
    resources :answers, except: %i[new index show]
    resources :comments, except: %i[new index show]
  end

end
