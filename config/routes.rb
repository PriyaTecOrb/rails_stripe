Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
    controllers tokens: 'tokens'
  end

  namespace :api, defaults: {format: "json"} do
    namespace :v1 do
      resources :registrations, only: [:create]
    end
  end
end
