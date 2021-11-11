json.extract! technician, :id, :name, :skill_level, :status, :created_at, :updated_at
json.url technician_url(technician, format: :json)
