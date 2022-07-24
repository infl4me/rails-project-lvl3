# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/destroy', to: 'auth#destroy'

    resources :bulletins do
      member do
        post 'to_moderate'
        post 'publish'
        post 'reject'
        post 'archive'
      end
    end

    namespace :admin do
      root 'bulletins#index'
      # TODO:
      resources :categories
      resources :users, only: %w[index]
    end

    namespace :profile do
      root 'bulletins#index'
    end
  end
end
