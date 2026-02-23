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
  end

  get "up" => "rails/health#show", as: :rails_health_check

  post "follow", to: "follows#follow"
  delete "unfollow", to: "follows#unfollow"

  resources :microposts, only: [ :create, :destroy, :show ] do
    resources :comments, only: [ :create ]
  end
end
