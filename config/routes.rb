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

  post "follow", to: "follows#follow"
  delete "unfollow", to: "follows#unfollow"

  resources :microposts, only: [ :create, :destroy, :show ] do
    resources :comments, only: [ :create ]
  end
end
