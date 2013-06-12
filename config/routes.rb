SetEditApp::Application.routes.draw do
  devise_for :users

  resources :cards

  root to: "cards#index"
end
