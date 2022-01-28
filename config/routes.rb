Rails.application.routes.draw do

  resources :items
  root 'pages#show', page: 'home'
  get '/pages/:page' => 'pages#show'

  # Users
  # Using Devise RegistrationsController for public user creation/registration.
  devise_for :users, controllers: { registrations: 'registrations' }
  # Using UsersController and /users/* paths for profile viewing and editing.
  resources :users, only: [:show, :edit, :update]
  # Namespacing to the '/admin/users' path, to avoid conflicting with Devise.
  scope 'admin' do
    resources :users, only: [:index, :new, :create, :destroy]
  end

  resources :accounts
  resources :brands
  resources :complication_types
  resources :complications
  resources :customer_types
  resources :customers
  resources :discounts
  resources :fees
  resources :invoice_items
  resources :invoices
  resources :item_statuses
  resources :item_types
  resources :quote_requests
  resources :repair_types
  resources :repairs
  resources :shop_parameters
  resources :standard_repairs
  resources :task_types
  resources :tasks
  resources :technicians
  resources :tickets
  resources :work_orders do
    resources :items
  end
end
