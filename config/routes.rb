Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :recipes, only: %i[index show] do
    resources :favorites, only: [:create]
  end
  resources :favorites, only: %i[index destroy]
end
