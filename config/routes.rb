Rails.application.routes.draw do
  root 'pages#index'

  get '/questions', to: 'questions#index'
  get '/questions/new', to: 'questions#new'
  post 'questions/create', to: 'questions#create'
end
