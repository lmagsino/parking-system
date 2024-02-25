Rails.application.routes.draw do
  resources :parking_lots, :except => [:new, :edit]
  resources :parking_slots, :only => [:new, :create, :index]
  resources :parking_transactions, :only => [:index]

  get "up" => "rails/health#show", as: :rails_health_check
  post 'vehicles/park', :to => 'vehicles#park'
  post 'vehicles/unpark', :to => 'vehicles#unpark'
end
