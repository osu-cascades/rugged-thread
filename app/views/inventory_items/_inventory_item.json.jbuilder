json.extract! inventory_item, :id, :repair_id, :standard_inventory_item_id, :price, :created_at, :updated_at
json.url inventory_item_url(inventory_item, format: :json)
