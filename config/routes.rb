Rails.application.routes.draw do
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
  get "/pages/:page" => "pages#show"


  root "pages#show", page: "home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
