Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get "dashboard/overview", to: "dashboard#overview"
  root to: "home#index"
end
