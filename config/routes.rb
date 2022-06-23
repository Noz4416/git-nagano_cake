Rails.application.routes.draw do

    root to: 'homes#top'
    get '/about' => 'homes#about', as: "about"

  namespace :admin do

    get '/customer/:id/orders_index' => 'customers#orders_index', as: "orders_index"
    get '/customer/:id/orders' => 'orders#index', as: "customer_orders"
    patch '/orders/:id/status' => 'orders#order_status_update', as: "order_status"
    patch '/orders/:id/making_status' => 'orders#making_status_update', as: "making_status"

    resources :orders, only:[:show,:index]
    resources :customers, only:[:index,:show,:edit,:update]
    resources :genres, only:[:new,:index,:edit,:create,:update]
    resources :items, only:[:new,:create,:index,:show,:edit,:update]


  end

  namespace :public do

    get 'customers/mypage' => 'customers#show'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'
    # get 'cart_items/destroy_all' => 'cart_items#destroy_all'
    get 'orders/thanx' => 'orders#thanx'
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/confirm' => 'orders#confirm'

    resources :cart_items do
      collection do
        delete 'destroy_all'
      end
    end
    resources :addresses, only:[:index, :edit, :update, :destroy, :create]
    resources :cart_items, only:[:index,:create,:update,:destroy]
    resources :orders, only:[:new,:index,:show,:create]
    resources :customers, only:[:show, :update, :edit]
    resources :items, only:[:index,:show]

    root to: 'homes#top'
  end


  devise_for :admin, skip:[:registrations,:passwords],controllers:{
    sessions:"admin/sessions"
  }

  devise_for :customers, skip:[:password],controllers:{
    registrations:"public/registrations",
    sessions:"public/sessions"
  }

  devise_scope :admin do
    get '/admin' => 'admin/sessions#new'
  end

end
