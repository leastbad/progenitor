Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get "dashboard/overview", to: "dashboard#overview"
  get "dashboard/traffic", to: "dashboard#traffic"
  get "dashboard/analysis", to: "dashboard#analysis"
  get "dashboard/map", to: "dashboard#map"
  get "kanban", to: "kanban#index"
  get "messages", to: "messages#index"
  get "messages/new", to: "messages#new"
  get "customers", to: "customers#index"
  get "transactions", to: "transactions#index"
  get "tasks", to: "tasks#index"
  get "settings", to: "settings#index"
  get "calendar", to: "calendar#index"
  get "map", to: "map#index"

  root to: "home#index"
end
