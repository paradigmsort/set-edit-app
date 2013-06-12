SetEditApp::Application.routes.draw do
  devise_for :users

  resources :cards
  resources :comments

  root to: "cards#index"
end
