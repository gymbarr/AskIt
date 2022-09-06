require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root 'pages#index'

    devise_for :users

    resources :questions do
      get 'vote_up', to: 'questions#vote_up'
      get 'vote_down', to: 'questions#vote_down'
    end

    resources :replies, except: %i[index show] do
      get 'vote_up', to: 'replies#vote_up'
      get 'vote_down', to: 'replies#vote_down'
    end

    resources :answers, except: %i[index show] do
      get 'vote_up', to: 'replies#vote_up'
      get 'vote_down', to: 'replies#vote_down'
    end

    resources :comments, except: %i[index show]

    resources :categories do
      resources :subscriptions, only: %i[create destroy]
    end
  end
end
