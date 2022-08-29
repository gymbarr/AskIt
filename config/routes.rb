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
      get 'answers/:id/vote_up', to: 'answers#vote_up', as: 'answer_vote_up'
      get 'answers/:id/vote_down', to: 'answers#vote_down', as: 'answer_vote_down'
    end

    resources :replies, except: %i[index show]
    # post :reply, to: 'replies#reply'
    # get :reply, to: 'replies#new'
    # get '/reply/:id/edit', to: 'replies#edit', as: 'edit_reply'
    # patch :reply, to: 'replies#update'
    # put :reply, to: 'replies#update'

    resources :categories do
      resources :subscriptions, only: %i[create destroy]
    end
  end
end
