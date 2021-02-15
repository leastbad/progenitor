Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get "dashboard/overview", to: "dashboard#overview"
  get "dashboard/traffic", to: "dashboard#traffic"
  get "dashboard/analysis", to: "dashboard#analysis"
  get "dashboard/map", to: "dashboard#map"
  root to: "home#index"
end
