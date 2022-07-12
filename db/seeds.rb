User.create!(name: 'Developer Admin', email: 'admin@example.com',
  password: 'password', password_confirmation: 'password', role: 'admin')
staff_user = User.create!(name: 'Developer Staff', email: 'staff@example.com',
  password: 'password', password_confirmation: 'password', role: 'staff')
User.create!(name: 'Developer Deactivated', email: 'deactivated@example.com',
  password: 'password', password_confirmation: 'password', role: 'admin',
  status: 'inactive')

(1..35).each { |i| User.create!(name: "zUser #{i}", email: "user#{i}@example.com",
  password: 'password', password_confirmation: 'password', role: 'staff') }

Account.create!(name: 'Atom Packs', turn_around: 21)
Account.create!(name: 'Burton', turn_around: 14)
Account.create!(name: 'Cotopaxl', turn_around: 21)
Account.create!(name: 'Gossamer Gear', turn_around: 14, cost_share: 30)
Account.create!(name: 'Trove', turn_around: 30)

(1..35).each { |i| Account.create!(name: "zAccount #{i}", turn_around: 14) }

brand = Brand.create!(name: "Arc'teryx")
Brand.create!(name: 'Black Diamond')
Brand.create!(name: 'Granite Gear')
Brand.create!(name: 'Zpacks')

(1..35).each { |i| Brand.create!(name: "zBrand #{i}") }

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

(1..35).each do |i|
  Customer.create!(first_name: 'Example', last_name: "zCustomer #{i}",
  business_name: "Example Biz #{i}", email_address: "customer#{i}@example.com",
  phone_number: '541-555-5555', alternative_phone_number: '541-555-5556',
  shipping_street_address: "1#{i} Sesame Street",
  shipping_city: 'Bend', shipping_state: 'OR', shipping_zip_code: '97704',
  billing_street_address: "1#{i} Sesame Street",
  billing_city: 'Bend', billing_state: 'OR', billing_zip_code: '97704',
  customer_type: b2c_local_customer_type)
end

standard_discount = StandardDiscount.create!(name: 'Coupon', price_cents: 1000)
StandardDiscount.create!(name: 'Employee', percentage_amount: 30)
StandardDiscount.create!(name: 'Investor', percentage_amount: 30)
StandardDiscount.create!(name: 'OEM Cost Share', percentage_amount: 30)
StandardDiscount.create!(name: 'Warranty', percentage_amount: 100)

standard_fee = StandardFee.create!(name: 'Cleaning', price_cents: 3500)
StandardFee.create!(name: 'Expedite', price_cents: 2500)
StandardFee.create!(name: 'Handling', price_cents: 500)
StandardFee.create!(name: 'Large Item', price_cents: 3500)
StandardFee.create!(name: 'Shipping', price_cents: 1000)
StandardFee.create!(name: 'Special Order', price_cents: 1000)

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

(1..35).each { |i| ItemType.create!(name: "zItem Type #{i}") }

ShopParameter.create!(name: 'B2C Local Turn Around', amount: 14)
ShopParameter.create!(name: 'B2C Ship Turn Around', amount: 21)
ShopParameter.create!(name: 'Cost of Labor', amount: 4600)
ShopParameter.create!(name: 'Minimum Complication', amount: 500)
ShopParameter.create!(name: 'Minimum Standard Repair', amount: 2000)
ShopParameter.create!(name: 'Standard Labor Rate', amount: 8000)

work_order = WorkOrder.create!(creator: staff_user, in_date: Date.today,
 shipping: true, customer: customer)

(1..35).each do |i|
  in_date = Date.today + rand(-10..10).days
  due_date = in_date + 14.days
  shipping = (rand(2) == 1)
  wo = WorkOrder.create!(
    creator: User.all.sample,
    in_date: in_date,
    due_date: due_date,
    shipping: shipping,
    customer: Customer.all.sample
  )
end

item = Item.create!(due_date: Date.today, notes: 'Collectors item, please handle carefully.',
  brand: brand, item_status: item_status, item_type: item_type, work_order: work_order)

Fee.create!(item: item, standard_fee: standard_fee, price_cents: 3500)
Discount.create!(item: item, standard_discount: standard_discount, price_cents: 1000)

StandardRepair.create!(name: "Slider Replacement: Separating Zipper", method: "",
  description: "YKK separating", level: 1, price_cents: 2000).tap do |sr|
    sr.standard_complications.create!(name: "Non-YKK brand or non-account inventory", price_cents: 500)
    sr.standard_complications.create!(name: "Add staple", price_cents: 500)
  end

(1..35).each do |i|
  StandardRepair.create!(name: "zzStandard Repair #{i}", method: "method #{i}",
    description: "repair description #{i}", level: i % 3 + 1, price_cents: i * 1000).tap do |sr|
      (1..12).each do |j|
        sr.standard_complications.create!(name: "zzStandard Complication #{j}", price_cents: j * 100)
      end
    end
end

standard_repair = StandardRepair.create!(name: "Zipper Replacement: Separating Zipper : As-Manufactured (per Half Zipper)", method: "",
 description: "< 24\" zipper length", level: 1, price_cents: 4500)
repair = Repair.create!(item: item, standard_repair: standard_repair, level: 1,
 price_cents: 4500, notes:"Fake Notes")

standard_repair.standard_complications.create!(name: "< 25-36\" zipper length",
  price_cents: 500)
standard_complication = standard_repair.standard_complications.create!(
  name: "< 37-48\" zipper length", price_cents: 1000)
Complication.create!(standard_complication: standard_complication, repair: repair, price_cents: 1000)

SpecialOrderItem.create!(name: "Gucci Gold-Plated Zipper Pull", price_cents: 5000,
  ordering_fee_price_cents: 1000, freight_fee_price_cents: 1500, repair: repair)

standard_inventory_item = StandardInventoryItem.create!(name: "SEEDED World Side Release Dual Adjust Buckle Latch (2\") Nexus",
  sku: "550-1100 SEEDED", price_cents: 100)
StandardInventoryItem.create!(name: "SEEDED World Side Release Dual Adjust Buckle Body (2\") Nexus",
  sku: "550-0100 SEEDED", price_cents: 100)
StandardInventoryItem.create!(name: "SEEDED World Side Release Buckle Latch (2\") Nexus",
  sku: "540-1100 SEEDED", price_cents: 100)
StandardInventoryItem.create!(name: "SEEDED World Side Release Buckle Latch (1\") Nexus",
  sku: "525-1100 SEEDED", price_cents: 100)
StandardInventoryItem.create!(name: "SEEDED World Side Release Buckle Body (2\") Nexus",
  sku: "540-0000 SEEDED", price_cents: 100)

standard_inventory_item.inventory_items.create!(repair: repair, price_cents: 100)

(1..35).each do |i|
  StandardInventoryItem.create!(name: "zzStandard Inventory Item #{i}",
    sku: "#{i}-0#{i}", price_cents: i * 100)
end
