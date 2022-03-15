json.extract! work_order, :id, :creator_id, :customer_id, :in_date, :due_date, :number, :shipping, :created_at, :updated_at
json.url work_order_url(work_order, format: :json)
