json.extract! item, :id, :due_date, :notes, :brand_id, :work_order_id, :item_status_id, :item_type_id, :created_at, :updated_at
json.url item_url(item, format: :json)
