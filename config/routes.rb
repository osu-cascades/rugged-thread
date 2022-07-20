Rails.application.routes.draw do

  root 'pages#home'

  get '/pages/:page' => 'pages#show'
  get '/dashboard' => 'dashboard#show'

  get '/qb_oauth' => 'quickbooks_o_auth#index'
  get '/qb_oauth_verify' => 'quickbooks_o_auth#verify'

  resources :quickbooks_customer_types

  resources :quickbooks_customers, except: [:destroy] do
    member do
      patch :archive
      patch :recover
    end
  end

  # Users
  # Using Devise RegistrationsController for public user creation/registration.
  devise_for :users, controllers: { registrations: 'registrations' }
  # Using UsersController and /users/* paths for profile viewing and editing.
  resources :users, only: [:show, :edit, :update]
  # Namespacing to the '/admin/users' path, to avoid conflicting with Devise.
  scope 'admin' do
    resources :users, only: [:index, :new, :create, :destroy] do
      patch :archive, on: :member
      patch :recover, on: :member
    end
  end

  resources :accounts do
    member do
      patch :archive
      patch :recover
    end
  end
  resources :brands do
    member do
      patch :archive
      patch :recover
    end
  end
  resources :complications, except: [:new, :create]
  resources :customer_types do
    member do
      patch :archive
      patch :recover
    end
  end
  resources :customers do
    resources :work_orders, only: :new
    member do
        patch :archive
        patch :recover
    end
  end
  resources :discounts, except: [:new, :create]
  resources :fees, except: [:new, :create]
  resources :inventory_items, except: [:new, :create]
  resources :item_statuses do
    patch 'set_default', on: :member
    member do
      patch :archive
      patch :recover
    end
  end
  resources :item_types do
    member do
      patch :archive
      patch :recover
    end
  end
  resources :items, except: [:new, :create] do
    get 'print', on: :member
    resources :discounts, only: :create
    resources :fees, only: :create
    resources :repairs, only: :create
  end
  resources :quote_requests
  resources :repairs, except: [:new, :create] do
    resources :complications, only: :create
    resources :inventory_items, only: :create
    resources :special_order_items, only: :create
  end
  resources :shop_parameters do
    member do
      patch :archive
      patch :recover
    end
  end
  resources :special_order_items, except: [:new, :create]
  resources :standard_complications do
    member do
      patch :archive
      patch :recover
    end
  end
  resources :standard_discounts do
    member do
      patch :archive
      patch :recover
    end
  end
  resources :standard_inventory_items do
    member do
      patch :archive
      patch :recover
    end
  end
  resources :standard_fees do
    member do
      patch :archive
      patch :recover
    end
  end
  resources :standard_repairs do
    resources :standard_complications, only: :new
    member do
      patch :archive
      patch :recover
    end
  end
  resources :work_orders do
    get 'print', on: :member
    member do
      patch :archive
      patch :recover
    end
    resources :items, only: :create
  end
end
