json.extract! invoice, :id, :estimate_number, :invoice_total, :intake_date, :date_fulfilled, :customer_id, :notes, :number, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
