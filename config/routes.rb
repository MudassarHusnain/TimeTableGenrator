Rails.application.routes.draw do

  resources :departments
  resources :courses
  resources :teachers
  devise_for :users


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "departments#index"
end
