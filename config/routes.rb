Appwithoauth::Application.routes.draw do
  root to: "home#index"
  match '/auth/:provider(/callback)', to: 'sessions#create', as: :login
  match '/logout', to: 'sessions#destroy', as: :logout
end
