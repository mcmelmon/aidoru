Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :contestants do
    member do
      get 'add_to_group', to: 'contestants#add_to_group'
      get 'remove_from_group', to: 'contestants#remove_from_group'
      get 'make_center', to: 'contestants#make_center'
    end
  end

  resources :groups do
    member do
      get 'add_random_members', to: 'groups#add_random_members'
      get 'make_current', to: 'groups#make_current_group'
    end
  end

  resources :users

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
