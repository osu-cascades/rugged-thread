json.extract! item, :id, :status, :due_date, :estimate, :labor_estimate, :notes, :brand_id, :work_order_id, :item_type_id, :created_at, :updated_at
json.url item_url(item, format: :json)
