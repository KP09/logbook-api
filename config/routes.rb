Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :passages, only: [:index, :create]
      resources :users, only: :create do
        collection do
          get 'api-test'
          post 'check_email_used'
          post 'confirm'
          post 'login'
        end
      end
    end
  end
end
