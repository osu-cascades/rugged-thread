require 'csv'

namespace :import do
  desc "Import standard inventory items"
  task :standard_inventory_items => :environment do
    DATA_SOURCE_PATH = Rails.root.join('lib/tasks', 'standard_inventory_items.csv')
    CSV.foreach(DATA_SOURCE_PATH, headers: true) do |row|
      name = row.fetch("Product/Service Name") || "UNKNOWN"
      original_sku = row.fetch("SKU")
      sku = row.fetch("SKU") || "UNKNOWN"
      price = row.fetch("Sales Price / Rate") || 0
      if price.to_f < 1
        price = 1
      end
      standard_inventory_item = StandardInventoryItem.new(
        name: name,
        sku: sku,
        price: price)
      begin
        standard_inventory_item.save!
      rescue
        puts "INVALID: #{standard_inventory_item.errors.messages}"
        puts original_sku
      end

    end
  end
end
