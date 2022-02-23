User.create!(name: 'Developer Admin', email: 'admin@example.com',
  password: 'password', password_confirmation: 'password', role: 'admin')
staff_user = User.create!(name: 'Developer Staff', email: 'staff@example.com',
  password: 'password', password_confirmation: 'password', role: 'staff')
User.create!(name: 'Developer Deactivated', email: 'deactivated@example.com',
  password: 'password', password_confirmation: 'password', role: 'admin',
  status: 'inactive')

Account.create!(name: 'Atom Packs', turn_around: 21)
Account.create!(name: 'Burton', turn_around: 14)
Account.create!(name: 'Cotopaxl', turn_around: 21)
Account.create!(name: 'Gossamer Gear', turn_around: 14, cost_share: 30)
Account.create!(name: 'Trove', turn_around: 30)

brand = Brand.create!(name: "Arc'teryx")
Brand.create!(name: 'Black Diamond')
Brand.create!(name: 'Granite Gear')
Brand.create!(name: 'Zpacks')

CustomerType.create!(name: 'B2B Local')
CustomerType.create!(name: 'B2B National')
b2c_local_customer_type = CustomerType.create!(name: 'B2C Local')
CustomerType.create!(name: 'B2C Ship')

customer = Customer.create!(first_name: 'Fred', last_name: 'Examplero',
  business_name: 'Example Biz Inc.', email_address: 'customer@example.com',
  phone_number: '541-555-5555', alternative_phone_number: '541-555-5556',
  shipping_street_address: '123 Sesame Street',
  shipping_city: 'Bend', shipping_state: 'OR', shipping_zip_code: '97704',
  billing_street_address: '123 Sesame Street',
  billing_city: 'Bend', billing_state: 'OR', billing_zip_code: '97704',
  customer_type: b2c_local_customer_type)

standard_discount = StandardDiscount.create!(name: 'Coupon', dollar_amount: 10)
StandardDiscount.create!(name: 'Employee', percentage_amount: 30)
StandardDiscount.create!(name: 'Investor', percentage_amount: 30)
StandardDiscount.create!(name: 'OEM Cost Share', percentage_amount: 30)
StandardDiscount.create!(name: 'Warranty', percentage_amount: 100)

standard_fee = StandardFee.create!(name: 'Cleaning', price: 35)
StandardFee.create!(name: 'Expedite', price: 25)
StandardFee.create!(name: 'Handling', price: 5)
StandardFee.create!(name: 'Large Item', price: 35)
StandardFee.create!(name: 'Shipping')
StandardFee.create!(name: 'Special Order', price: 10)

ItemStatus.create!(name: 'INVOICED')
ItemStatus.create!(name: 'ON HOLD')
ItemStatus.create!(name: 'PRICED')
item_status = ItemStatus.create!(name: 'PROD', default: true)

item_type = ItemType.create!(name: "Bag")
ItemType.create!(name: "Biking")
ItemType.create!(name: "Biking Bag")
ItemType.create!(name: "Biking Jersey")
ItemType.create!(name: "Dog Gear")
ItemType.create!(name: "Dog Booties")
ItemType.create!(name: "Pack")
ItemType.create!(name: "Water Sports")

ShopParameter.create!(name: 'B2C Local Turn Around', amount: 14)
ShopParameter.create!(name: 'B2C Ship Turn Around', amount: 21)
ShopParameter.create!(name: 'Cost of Labor', amount: 46)
ShopParameter.create!(name: 'Minimum Complication', amount: 5)
ShopParameter.create!(name: 'Minimum Standard Repair', amount: 20)
ShopParameter.create!(name: 'Standard Labor Rate', amount: 80)

work_order = WorkOrder.create!(creator: staff_user, in_date: Date.today,
 shipping: true, customer: customer)

item = Item.create!(due_date: Date.today, notes: 'Collectors item, please handle carefully.',
  brand: brand, item_status: item_status, item_type: item_type, work_order: work_order)

Fee.create!(item: item, standard_fee: standard_fee, price: 35)
Discount.create!(item: item, standard_discount: standard_discount, percentage_amount: 10, dollar_amount:15)

standard_repair = StandardRepair.create!(name: "Zipper Replacement: Separating Zipper : As-Manufactured (per Half Zipper)", method: "",
 description: "< 24\" zipper length", level: 1, charge: 45)
repair = Repair.create!(item: item, standard_repair: standard_repair, level: 1,
 price: 45, notes:"Fake Notes")

standard_repair.standard_complications.create!(name: "< 25-36\" zipper length",
  charge: 5)
standard_complication = standard_repair.standard_complications.create!(
  name: "< 37-48\" zipper length", charge: 10)
Complication.create!(standard_complication: standard_complication, repair: repair, price: 10)
