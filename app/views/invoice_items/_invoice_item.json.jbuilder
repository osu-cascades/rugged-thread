json.extract! invoice_item, :id, :description, :invoice_number, :quote, :charge, :notes, :invoice_id, :item_type_id, :created_at, :updated_at
json.url invoice_item_url(invoice_item, format: :json)
