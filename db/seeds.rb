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

WorkOrder.create!(in_date: Date.today, estimate: 100, shipping: true, customer: customer)

Brand.create!(name: 'Example Brand One')
Brand.create!(name: 'Example Brand Two')

ItemStatus.create!(name: 'Example Status One')
ItemStatus.create!(name: 'Example Status Two')

ItemType.create(name: 'Example Item Type One')
ItemType.create(name: 'Example Item Type Two')
