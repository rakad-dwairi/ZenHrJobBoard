Rails.application.routes.draw do


  post '/login', to: 'sessions#create'
  post '/register', to: 'registrations#create'
  resources :job_posts, only: [:index, :create, :update, :destroy]
  resources :job_applications, only: [:index, :create]

  resources :job_posts do
    collection do
      get :search
    end
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
