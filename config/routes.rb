Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :contact_messages

  resources :contestants do
    member do
      get 'add_to_group', to: 'contestants#add_to_group'
      get 'groups', to: 'contestants#groups'
      get 'like', to: 'contestants#like'
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

  resources :users do
    get 'groups', to: 'users#groups'
  end

  get 'about', to: 'home#about'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
