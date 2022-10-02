require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root 'pages#index'

    devise_for :users
    resources :users

    resources :questions

    post 'questions/:id/vote_up', to: 'questions#vote_up', as: :question_vote_up
    post 'questions/:id/vote_down', to: 'questions#vote_down', as: :question_vote_down

    resources :answers, except: %i[index show]

    post 'answers/:id/vote_up', to: 'answers#vote_up', as: :answer_vote_up
    post 'answers/:id/vote_down', to: 'answers#vote_down', as: :answer_vote_down

    resources :comments, except: %i[index show]
    post 'answers/:id/load_more_comment', to: 'comments#load_more_comments', as: :load_more_comments

    resources :categories do
      resources :subscriptions, only: %i[create destroy]
    end
  end
end
