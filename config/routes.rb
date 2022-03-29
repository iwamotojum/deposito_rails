Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'materials#index'

  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :users, except: [:new]
  resources :materials, except: [:show]

  get "materials/:id/input", to: 'materials#add', as: 'material_add'
  patch "materials/:id/input", to: 'materials#input', as: 'material_input'
  get "materials/:id/output", to: 'materials#remove', as: 'material_remove'
  patch "materials/:id/output", to: 'materials#output', as: 'material_output'
  get "materials/:id/logs", to: 'materials#logs', as: 'material_log'
  delete "materials/:id", to: 'materials#destroy', as: 'material_destroy'
end
