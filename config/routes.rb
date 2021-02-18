Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :managements,only:[:index]
  end
end
