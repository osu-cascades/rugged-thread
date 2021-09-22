json.extract! quote_request, :id, :first_name, :last_name, :email, :phone_number, :item_type, :brand, :will_mail_item, :promo_code, :description, :images, :created_at, :updated_at
json.url quote_request_url(quote_request, format: :json)
json.images do
  json.array!(quote_request.images) do |image|
    json.id image.id
    json.url url_for(image)
  end
end
