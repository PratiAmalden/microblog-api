Rails.application.routes.draw do
  devise_for :users,
    path: "",
    path_names: {
      sign_in: "users/signin",
      sign_out: "users/signout"
    },
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }

  devise_scope :user do
    post "users/signup", to: "users/registrations#create"
    post "users/signout", to: "users/sessions#destroy"
  end

  get "up" => "rails/health#show", as: :rails_health_check

  get "feed", to: "users#feed"

  resources :follows, only: [ :create, :destroy ]

  resources :microposts do
    resources :comments do
      resources :reactions, only: [ :create, :destroy ]
    end
    resources :reactions, only: [ :create, :destroy ]
  end

  match "*unmatched", to: "application#route_not_found", via: :all
end
