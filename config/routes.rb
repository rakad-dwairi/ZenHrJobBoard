Rails.application.routes.draw do
  if Rails.env.development?
    match '/404', to: 'errors#not_found', via: :all
    match '/500', to: 'errors#internal_server_error', via: :all
  end
  
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users

  post '/login', to: 'authentication#login'
  post '/register', to: 'users#create'

  resources :job_posts
  resources :job_applications

  # Remove the catch-all route
  # get '*path', to: 'application#handle_404'
  
  #match '*unmatched', to: 'application#handle_404', via: :all
end
