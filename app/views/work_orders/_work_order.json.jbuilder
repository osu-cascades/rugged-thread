json.extract! work_order, :id, :in_date, :estimate, :shipping, :created_at, :updated_at
json.url work_order_url(work_order, format: :json)
