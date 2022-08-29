require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root 'pages#index'

    resources :users, only: %i[new create]
    resource :session, only: %i[new create destroy]

    resources :questions do
      resources :answers, except: %i[new index show]
      resources :comments, except: %i[index show]

      get 'vote_up', to: 'questions#vote_up'
      get 'vote_down', to: 'questions#vote_down'
    end

    resources :replies, except: %i[index show] do
      get 'vote_up', to: 'replies#vote_up'
      get 'vote_down', to: 'replies#vote_down'
    end

    # get 'answers/:id/vote_up', to: 'answers#vote_up', as: 'answer_vote_up'
    # get 'answers/:id/vote_down', to: 'answers#vote_down', as: 'answer_vote_down'

    resources :categories do
      resources :subscriptions, only: %i[create destroy]
    end
  end
end
