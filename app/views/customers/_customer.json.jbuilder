json.extract! customer, :id, :first_name, :last_name, :business_name, :phone_number, :alternative_phone_number, :email_address, :street_address, :city, :state, :zip_code, :billing_street_address, :billing_city, :billing_state, :billing_zip_code, :created_at, :updated_at
json.url customer_url(customer, format: :json)
