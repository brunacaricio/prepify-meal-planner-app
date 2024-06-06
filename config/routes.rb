Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :recipes, only: %i[index show] do

    resources :favorites, only: [:create]

    resources :planned_meals, only: [:create]

  end

  resources :favorites, only: %i[index destroy]

  # index or show # does it need a grocery list

  resources :planned_meals, only: [:index]

  #what needs to be nested ?

  #what is created where ?

  #what needs a controller ?

end
