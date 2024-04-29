Rails.application.routes.draw do
  get 'all_users',to: 'teachers_students_users#index'
  patch 'all_users_update/:id', to: 'teachers_students_users#update', as: 'all_users_update'
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
  resource :makeups
  devise_for :users, controllers: {
    passwords: 'passwords/passwords',
    registrations: 'passwords/registrations',
    sessions: 'passwords/sessions',
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "departments#index"
end
