Rails.application.routes.draw do
  root 'pages#index'

  resources :users, only: %i[new create]

  resources :questions do
    resources :answers, except: %i[new index show]
    resources :comments, except: %i[new index show]
  end

end
