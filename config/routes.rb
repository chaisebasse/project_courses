Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :courses
  resources :sections, except: :index
  resources :videos, except: :index
  resources :orders do
    resources :payments
  end

  mount StripeEvent::Engine, at: '/stripe-webhooks'
end
