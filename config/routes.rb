Rails.application.routes.draw do
  resources :accounts
  resources :shop_parameters
  resources :discounts
  resources :fees
  resources :item_statuses
  resources :customer_types
  resources :tasks
  resources :task_types
  resources :quote_requests
  devise_for :users
  resources :users
  resources :complications
  resources :complication_types
  resources :repairs
  resources :repair_types
  resources :brands
  resources :invoice_items
  resources :item_types
  resources :tickets
  resources :invoices
  resources :technicians
  resources :customers
  resources :work_orders, only: [:edit]
  get "/pages/:page" => "pages#show"


  root "pages#show", page: "home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
