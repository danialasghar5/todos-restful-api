Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
        resources :todos do
           resources :items
        end
    end
end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
