Rails.application.routes.draw do
  devise_for :users, controllers: {
    masquerades: "users/masquerades",
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  get "dashboard/overview", to: "dashboard#overview"
  get "dashboard/traffic", to: "dashboard#traffic"
  get "dashboard/analysis", to: "dashboard#analysis"
  get "dashboard/explore", to: "dashboard#explore"
  get "kanban", to: "kanban#index"
  get "messages", to: "messages#index"
  get "messages/new", to: "messages#new"
  get "customers", to: "customers#index"
  get "transactions", to: "transactions#index"
  get "tasks", to: "tasks#index"
  get "settings", to: "settings#index"
  get "calendar", to: "calendar#index"
  get "map", to: "map#index"
  get "files", to: "uploaded_files#index"
  get "pages/invoice", to: "pages#invoice"
  get "pages/sign-in", to: "pages#sign_in"
  get "pages/sign-up", to: "pages#sign_up"
  get "pages/forgot-password", to: "pages#forgot_password"
  get "pages/reset-password", to: "pages#reset_password"
  get "pages/lock", to: "pages#lock"
  get "pages/error-404", to: "pages#error_404"
  get "pages/error-500", to: "pages#error_500"
  get "components/beacons", to: "components#beacons"
  get "components/buttons", to: "components#buttons"
  get "components/forms", to: "components#forms"
  get "components/modals", to: "components#modals"
  get "components/typography", to: "components#typography"
  get "components/youtube", to: "components#youtube"
  get "cards", to: "cards#index"

  root "home#index"
end
