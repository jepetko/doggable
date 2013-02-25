Doggable::Application.routes.draw do
  resources :dogs, :except => [:show]
  resources :skills

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end