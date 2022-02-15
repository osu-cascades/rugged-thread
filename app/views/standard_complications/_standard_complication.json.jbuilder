json.extract! standard_complication, :id, :name, :method, :description, :level, :charge, :created_at, :updated_at, :standard_repair_id
json.url standard_complication_url(standard_complication, format: :json)
