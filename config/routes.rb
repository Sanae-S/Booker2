Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :books
  get 'home/about' =>"home#about"
  root 'home#index'
  get 'destroy_user_session_path' => 'root_path'
end
