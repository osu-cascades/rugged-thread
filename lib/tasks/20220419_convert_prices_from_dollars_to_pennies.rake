namespace :convert do
  desc "Convert all prices from dollars to pennies"
  task :dollars_to_pennies => :environment do
    [
      Complication,
      Discount,
      Fee,
      InventoryItem,
      Repair,
      SpecialOrderItem,
      StandardComplication,
      StandardDiscount,
      StandardFee,
      StandardInventoryItem,
      StandardRepair
    ].each { |klass| update_prices(klass) }
  end
end

def update_prices(klass)
  klass.all.each do |o|
    o.update_attribute(:price, o.price * 100) unless o.price.blank?
  end
end
