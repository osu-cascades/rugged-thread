json.extract! ticket, :id, :repair_description, :add_fee, :technician_notes, :work_status, :technician_id, :invoice_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
