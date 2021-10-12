json.extract! task, :id, :time, :tech_name, :repair_charge, :repair_number, :task_type_name, :created_at, :updated_at
json.url task_url(task, format: :json)
