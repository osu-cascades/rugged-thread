json.extract! user, :id, :name, :permission, :end_date, :efficiency, :created_at, :updated_at
json.url user_url(user, format: :json)
