Rails.application.routes.draw do
  resources :departments do
    resources :courses
    resources :teachers
    resources :rooms
    resources :dep_classes do
      resources :class_course_slots
      get '/generate_pdf', to: 'dep_classes#download_pdf'
    end
    resources :slots
  
  end
  devise_for :users


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "departments#index"
end
