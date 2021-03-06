Depot::Application.routes.draw do
  resources :categories


  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  scope '(:locale)' do
    resources :orders
    resources :users
    resources :line_items do
      get :decrease, on: :collection
    end
    resources :carts
    resources :products do
      get :who_bought, on: :member
    end
    root to: 'store#index', as: 'store'
  end

  root :to => 'store#index', as: 'store'

end
