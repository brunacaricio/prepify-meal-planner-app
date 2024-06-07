Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :recipes, only: %i[index show] do

    resources :favorites, only: [:create]
    resources :planned_meals, only: [:create]

  end

  resources :favorites, only: %i[index destroy]
  resources :planned_meals, only: [:index]

  resources :grocery_lists, only: [:update, :index]
end
