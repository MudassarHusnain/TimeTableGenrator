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
    get '/dep_time_table', to: 'departments#department_time_table'
  
  end
  devise_for :users, controllers: { passwords: 'passwords/passwords' }


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "departments#index"
end
