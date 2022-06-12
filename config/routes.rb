Rails.application.routes.draw do

    root to: 'homes#top'
    get '/about' => 'homes#about', as: "about"

  namespace :admin do
    root to: 'homes#top'
    get '/customer/:id/orders' => 'orders#index', as: "customer_orders"

    resources :orders, only:[:show,:index]
    resources :customers, only:[:index,:show,:edit]
    resources :genres, only:[:new,:index,:edit,:create,:update]
    resources :items, only:[:new,:create,:index,:show,:edit,:update]


  end

  namespace :public do

    get 'customers/mypage' => 'customers#show'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    get 'customers/withdraw' => 'customers#withdraw'
    get 'cart_items/destroy_all' => 'cart_items#destroy_all'
    get 'orders/thanx' => 'orders#thanx'
    get 'orders/confirm' => 'orders#confirm'

    resources :addresses, only:[:index, :edit, :update, :destroy, :create]
    resources :cart_items, only:[:index]
    resources :orders, only:[:new,:index,:show]
    resources :customers, only:[:show, :update, :edit]
    resources :items, only:[:index,:show]

    root to: 'homes#top'
  end





  devise_for :admin,skip:[:registrations,:passwords],controllers:{
    sessions:"admin/sessions"
  }

  devise_for :customers,skip:[:password],controllers:{
    registrations:"public/registrations",
    sessions:"public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
