Rails.application.routes.draw do


  post "extend_meal", to: "students#extend_meal"

 get 'my_details', to: 'students#my_details', as: 'my_details'
 

  post 'send_email', to: 'emails#send_email'



  get 'admin/set_custom_and_meal_time', to: 'admin#set_custom_and_meal_time'
  post 'admin/update_meal_timings', to: 'admin#update_meal_timings'


  get "landing_page/index"
  get "carts/empty_cart"




  get '/fetch_receipt', to: 'receipts#fetch_receipt'
  post '/fetch_receipt', to: 'receipts#show_receipt'
  



post "/admin/update_meal_charge", to: "admin#update_meal_charge", as: :update_meal_charge_admin  #for charge_per_meal
get "/gallery/setting_meal_charge", to: "gallery#setting_meal_charge", as: :setting_meal_charge

  
  resources :line_items
  resources :carts

  get 'gallery/index'
  get 'gallery/checkout'
  post 'gallery/checkout'
   get 'gallery/purchase_complete'
  resources :customized_foods

  namespace :admin do
    get "admin/login"
    post "admin/login"
    get "admin/logout"
    resources :menus 
  end
  resources :menus #, only: [:index]                      # Users can only view the menu
  resources :menus, only: [:index]

   
  resources :receipts do
    member do
    post 'extend_meal'
    end
  end



  resources :receipts
  resources :receipts do
    collection do
      get 'search_by_email'
    end
  end


  resources :students
  get "admin/login"
  post "admin/login"
  get "admin/logout"






 
  devise_for :users
  root to: "landing_page#index"
 

  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
