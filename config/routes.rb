Rails.application.routes.draw do
  root 'pages#index'

  resources :users, only: %i[new create]
  resource :session, only: %i[new create destroy]

  resources :questions do
    resources :answers, except: %i[new index show]
    resources :comments, except: %i[new index show]
    
    get 'vote_up', to: 'questions#vote_up'
    get 'vote_down', to: 'questions#vote_down'
  end

end
