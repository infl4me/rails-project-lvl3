# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/destroy', to: 'auth#destroy'

    resources :bulletins do
      member do
        patch 'to_moderate'
        patch 'archive'
      end
    end

    namespace :admin do
      root 'bulletins#index'

      resources :bulletins, only: %w[index] do
        member do
          patch 'publish'
          patch 'reject'
          patch 'archive'
        end
      end

      resources :users, only: %w[index]
      resources :categories
    end

    get 'profile', to: 'profile/bulletins#index'
  end
end
