Rails.application.routes.draw do
  resources :parking_lots, :except => [:new, :edit]

  get "up" => "rails/health#show", as: :rails_health_check
end
