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

CustomerType.create!(name: 'B2B Local', turn_around: 14)
CustomerType.create!(name: 'B2B National', turn_around: 21)
b2c_local_customer_type = CustomerType.create!(name: 'B2C Local', turn_around: 14)
CustomerType.create!(name: 'B2C Ship', turn_around: 30)

customer = Customer.create!(first_name: 'Fred', last_name: 'Examplero',
  business_name: 'Example Biz Inc.', email_address: 'customer@example.com',
  phone_number: '541-555-5555', alternative_phone_number: '541-555-5556',
  shipping_street_address: '123 Sesame Street',
  shipping_city: 'Bend', shipping_state: 'OR', shipping_zip_code: '97704',
  billing_street_address: '123 Sesame Street',
  billing_city: 'Bend', billing_state: 'OR', billing_zip_code: '97704',
  customer_type: b2c_local_customer_type)

standard_discount = StandardDiscount.create!(name: 'Coupon', price: 10)
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
Discount.create!(item: item, standard_discount: standard_discount, price: 10)

StandardRepair.create(name: "Slider Replacement: Separating Zipper", method: "",
  description: "YKK separating", level: 1, price: 20).tap do |sr|
    sr.standard_complications.create!(name: "Non-YKK brand or non-account inventory", price: 5)
    sr.standard_complications.create!(name: "Add staple", price: 5)
  end

standard_repair = StandardRepair.create!(name: "Zipper Replacement: Separating Zipper : As-Manufactured (per Half Zipper)", method: "",
 description: "< 24\" zipper length", level: 1, price: 45)
repair = Repair.create!(item: item, standard_repair: standard_repair, level: 1,
 price: 45, notes:"Fake Notes")

standard_repair.standard_complications.create!(name: "< 25-36\" zipper length",
  price: 5)
standard_complication = standard_repair.standard_complications.create!(
  name: "< 37-48\" zipper length", price: 10)
Complication.create!(standard_complication: standard_complication, repair: repair, price: 10)

SpecialOrderItem.create!(name: "Gucci Gold-Plated Zipper Pull", price: 50, repair: repair)

standard_inventory_item = StandardInventoryItem.create!(name: "SEEDED World Side Release Dual Adjust Buckle Latch (2\") Nexus",
  sku: "550-1100 SEEDED", price: 1)
StandardInventoryItem.create!(name: "SEEDED World Side Release Dual Adjust Buckle Body (2\") Nexus",
  sku: "550-0100 SEEDED", price: 1)
StandardInventoryItem.create!(name: "SEEDED World Side Release Buckle Latch (2\") Nexus",
  sku: "540-1100 SEEDED", price: 1)
StandardInventoryItem.create!(name: "SEEDED World Side Release Buckle Latch (1\") Nexus",
  sku: "525-1100 SEEDED", price: 1)
StandardInventoryItem.create!(name: "SEEDED World Side Release Buckle Body (2\") Nexus",
  sku: "540-0000 SEEDED", price: 1)

standard_inventory_item.inventory_items.create!(repair: repair, price: 1)
