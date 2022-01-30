User.create!(name: 'Developer Admin', email: 'admin@example.com',
 password: 'password', password_confirmation: 'password', role: 'admin')
User.create!(name: 'Developer Staff', email: 'staff@example.com',
 password: 'password', password_confirmation: 'password', role: 'staff')
User.create!(name: 'Developer Deactivated', email: 'deactivated@example.com',
 password: 'password', password_confirmation: 'password', role: 'admin',
 status: 'inactive')
 
customer = Customer.create!(  first_name: 'Example', last_name: 'Customer',
 business_name: 'Example Business', phone_number: '541-555-5555',
 email_address: 'exampleCustomer@email.com', street_address: '123 Sesame Street', city: 'Bend', 
 state: 'OR', zip_code: '97704')

work_order = WorkOrder.create!(in_date: Date.today, shipping: true, customer: customer)

brand = Brand.create!(name: 'Example Brand One')
Brand.create!(name: 'Example Brand Two')

item_status = ItemStatus.create!(name: 'Example Status One')
ItemStatus.create!(name: 'Example Status Two')

item_type = ItemType.create(name: 'Example Item Type One')
ItemType.create(name: 'Example Item Type Two')

Item.create!(due_date: Date.today, estimate: 100, labor_estimate: 50, notes: 'This is the place for notes.', brand: brand, item_status: item_status, item_type: item_type, work_order: work_order)
