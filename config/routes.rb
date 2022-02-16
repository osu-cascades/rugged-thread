Rails.application.routes.draw do

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
  resources :customer_types
  resources :customers do
    resources :work_orders, only: :new
  end
  resources :standard_discounts
  resources :standard_fees
  resources :invoice_items
  resources :invoices
  resources :item_statuses do
    patch 'set_default', on: :member
  end
  resources :item_types
  resources :items, except: [:new, :create] do
    resources :repairs, only: :create
    resources :discounts, only: :create
    resources :fees, only: :create
  end
  resources :quote_requests
  resources :fees, except: [:new, :create]
  resources :discounts, except: [:new, :create]
  resources :repairs, except: [:new, :create]
  resources :shop_parameters
  resources :standard_complications
  resources :standard_repairs do
    resources :standard_complications, only: :new
  end
  resources :task_types
  resources :tasks
  resources :technicians
  resources :tickets
  resources :work_orders do
    resources :items, only: :create
  end
end
