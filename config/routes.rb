Rails.application.routes.draw do
  namespace :authentication, path: '', as: ''  do
    resources :users, only: [:new, :create], path: '/register', path_names: {new: '/'}
    resources :sessions, only: [:new, :create, :destroy], path: '/login', path_names: {new: '/'}
  end
  
  #Todas las rutas de del controlador category
  resources :categories, except: :show
  
  #peticion para eliminar 
  delete '/products/:id', to: 'products#destroy', as: :destroy_product
  #peticion para actualizar algo
  patch '/products/:id', to: 'products#update' 
  post '/products', to: 'products#create'
  #peticion para llegar a una ruta 
  get '/products/new', to: 'products#new', as: :new_product
  get '/products', to: 'products#index'
  get '/products/:id', to: 'products#show', as: :product
  get '/products/:id/edit', to: 'products#edit', as: :edit_product 

  resources :favorites, only: [:index, :create, :destroy], param: :product_id
  resources :users, only: :show, path: '/user', param: :username
  resources :products, path: '/' 
end
