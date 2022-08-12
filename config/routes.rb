Rails.application.routes.draw do
  root 'pages#index'

  resources :questions, except: %i[destroy show]

end
