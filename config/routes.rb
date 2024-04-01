Rails.application.routes.draw do
  resources :department do
    resources :courses
    resources :teachers
    resources :department_classes

  end
  devise_for :users


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "departments#index"
end
