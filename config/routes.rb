Rails.application.routes.draw do
  resources :tasks
  resources :task_types
  resources :quote_requests
  devise_for :users
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
  resources :ticket_data_entries

  get "/pages/:page" => "pages#show"
  get "/ticketdataentry", to: "ticket_data_entries#new"

  root "pages#show", page: "home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
