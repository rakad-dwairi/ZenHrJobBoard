Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users

  post '/auth/login', to: 'authentication#login'
  post '/register', to: 'users#create'

  resources :job_posts
  resources :job_applications


  #get '/swagger_docs', to: 'SwaggerUiController#index'
end
