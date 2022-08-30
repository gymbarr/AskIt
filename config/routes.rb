require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  mount Sidekiq::Web => '/sidekiq'

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root 'pages#index'

    resources :questions do
      get 'vote_up', to: 'questions#vote_up'
      get 'vote_down', to: 'questions#vote_down'
    end

    resources :replies, except: %i[index show] do
      get 'vote_up', to: 'replies#vote_up'
      get 'vote_down', to: 'replies#vote_down'
    end

    resources :categories do
      resources :subscriptions, only: %i[create destroy]
    end
  end
end
