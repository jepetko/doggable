Doggable::Application.routes.draw do
  resources :dogs, :except => [:show] do
    member do
      get :skills
    end
  end
  resources :skills

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end