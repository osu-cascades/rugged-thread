User.create!(name: 'Developer Admin', email: 'admin@example.com',
 password: 'password', password_confirmation: 'password', role: 'admin')
User.create!(name: 'Developer Staff', email: 'staff@example.com',
 password: 'password', password_confirmation: 'password', role: 'staff')
User.create!(name: 'Developer Deactivated', email: 'deactivated@example.com',
 password: 'password', password_confirmation: 'password', role: 'admin',
 status: 'inactive')
