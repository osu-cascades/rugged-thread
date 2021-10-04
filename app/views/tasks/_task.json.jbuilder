json.extract! task, :id, :time, :number, :technician, :repair_charge, :task_type_id, :technician_id, :created_at, :updated_at
json.url task_url(task, format: :json)
