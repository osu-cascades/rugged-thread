json.extract! quote_request, :id, :first_name, :last_name, :email, :phone_number, :item_type_id, :brand_id, :shipping, :promo_code, :description, :photos, :status :created_at, :updated_at
json.url quote_request_url(quote_request, format: :json)
json.photos do
  json.array!(quote_request.photos) do |image|
    json.id photo.id
    json.url url_for(photo)
  end
end
