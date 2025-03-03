Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"

  namespace :author do
    resources :decks
    resources :quizzes
  end

  resources :answer_sheets, only: %i[create destroy show] do
    member do
      get "pause"
      get "resume"
    end
  end

  resources :answer_sheet_questions, only: %i[show update]

  namespace :dashboard do
    resources :users, only: %i[show update]
  end

  resources :decks, only: %i[index show] do
    resources :cards, shallow: true, module: :decks
  end

  resources :quizzes, only: %i[index show] do
    resources :questions, only: %i[create edit destroy new show update]
  end

  resources :questions, only: [] do
    resources :choices, only: %i[create destroy edit new update], module: :questions
  end
end
