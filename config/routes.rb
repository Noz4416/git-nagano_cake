Rails.application.routes.draw do
  
  namespace :admin do
    resources :orders, only:[:show]
    resources :customers, only:[:index,:show,:edit]
    resources :genres, only:[:index,:edit]
    resources :items, only:[:new,:index,:show,:edit]

    root to: 'homes#top'
  end

  namespace :public do
    resources :customers, only:[:edit]
    get 'customers/mypage' => 'customers#show'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    get 'customers/withdraw' => 'customers#withdraw'
    
    resources :addresses, only:[:index, :edit]
    resources :orders, only:[:new,:index,:show]
    get 'orders/thanx' => 'orders#thanx'
    get 'orders/confirm' => 'orders#confirm'
    
    resources :cart_items, only:[:index]
    get 'cart_items/destroy_all' => 'cart_items#destroy_all'
    
    resources :items, only:[:index,:show]

    root to: 'homes#top'
    get '/about' => 'homes#about'

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
