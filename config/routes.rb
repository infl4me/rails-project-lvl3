# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    resources :bulletins

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/destroy', to: 'auth#destroy'

    namespace :admin do
      resources :categories
    end
  end
end
