Rails.application.routes.draw do
  get '/' => "toppages#index"
  resources :tasks
  
  root to: "tasks#index"
end
