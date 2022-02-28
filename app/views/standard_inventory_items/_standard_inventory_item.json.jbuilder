json.extract! standard_inventory_item, :id, :name, :price, :created_at, :updated_at, :sku
json.url standard_inventory_item_url(standard_inventory_item, format: :json)
