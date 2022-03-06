json.extract! customer_type, :id, :name, :turn_around, :customers_count, :created_at, :updated_at
json.url customer_type_url(customer_type, format: :json)
