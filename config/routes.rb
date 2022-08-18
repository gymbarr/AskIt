Rails.application.routes.draw do
  root 'pages#index'

  resources :users, only: %i[new create]
  resource :session, only: %i[new create destroy]

  resources :questions do
    resources :answers, except: %i[new index show]
    resources :comments, except: %i[new index show]
    
    get 'vote_up', to: 'questions#vote_up'
    get 'vote_down', to: 'questions#vote_down'
    get 'answers/:id/vote_up', to: 'answers#vote_up', as: 'answer_vote_up'
    get 'answers/:id/vote_down', to: 'answers#vote_down', as: 'answer_vote_down'
  end

end
