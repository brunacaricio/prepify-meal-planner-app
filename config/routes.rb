Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :recipes, only: %i[index show] do

    resources :favorites, only: [:create]
    resources :planned_meals, only: [:create]

  end

  resources :grocery_lists do
    resources :grocery_list_items, only: :update
  end

  resources :favorites, only: %i[index destroy]
  resources :planned_meals, only: %i[index destroy]

  resources :grocery_lists, only: %i[update index]
end
