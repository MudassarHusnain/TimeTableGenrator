Rails.application.routes.draw do
  resources :departments do
    resources :courses
    resources :teachers
    resources :rooms
    resources :dep_classes


  end
  devise_for :users


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "departments#index"
end
