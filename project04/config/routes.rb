Depot::Application.routes.draw do
  get "store/index"

  resources :products

  # makes the '/' path go to /store/index and lets us easily access this with
  # store_path()
  root to: 'store#index', as: 'store' 

end
