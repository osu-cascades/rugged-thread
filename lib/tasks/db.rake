require 'json'

namespace :db do
  desc "Import production database values"
  task import_prod_vals: :environment do
    json = JSON.parse(File.read('lib/assets/production_values.json'))
    (1..4238).map do |num|
      Customer.create!(
        id: num,
        first_name: "FirstName",
        last_name: "LastName",
        business_name: "BusinessName",
        phone_number: "28572415082175",
        email_address: "Test.mail.com",
        street_address: "Street Adress",
        city: "City",
        state: "State",
        zip_code: "1232344553"
      )
      invoice_ests = json[num]['Estimate']
      invoice_intakes = json[num]['In Date']
      invoice_nums = json[num]['Invoice']
      item_nums = json[num]['Item No']
      item_type_num = json[num]['Items']
      repair_type_nums = json[num]['Repairs']
      repair_nums = json[num]['Repair No']
      repair_charges = json[num]['Repair Charge__1']
      repair_times = json[num]['Repair Time']
      repair_dates = json[num]['Repair Date']
      tech_names = json[num]['Tech']
      tasks = json[num]['Task']
      task_time = json[num]['Task Time']
      item_quotes = json[num]['Item Quote']
      item_charges = json[num]['Item Charge']
      shop_rates = json[num]['Shop Rate']
      solo_techs = json[num]['Solo Tech']
      first_repair_charge = json[num]['Repair Charge']
      Invoice.create!(
        id: num,
        customer_id: num,
        invoice_estimate: invoice_ests,
        intake_date: invoice_intakes,
        number: invoice_nums,
      )
      ItemType.create!(
        id: num,
        number: item_type_num.to_s
      )
      RepairType.create!(
        number: repair_type_nums
      )
      Technician.create!(
        name: tech_names
      )
      Repair.create!(
        number: repair_nums,
        date: Date.strptime(repair_dates, "%m/%d/%y").strftime('%m/%d/%y'),
        charge: repair_charges.to_i.to_f,
        time_total: repair_times.to_s,
        time: repair_times.to_s,
        shop_rate: shop_rates.to_i.to_f,
      )
      TaskType.create!(
        name: tasks,
      )
      Task.create!(
        time: task_time.to_i,
        tech_name: solo_techs,
        repair_charge: first_repair_charge,
        task_type_id: num,
        technician_id: num
      )
      InvoiceItem.create!(
        id: num,
        number: item_nums,
        quote: item_quotes.to_i.to_f,
        charge: item_charges.to_i.to_f
      )
    end
  end
end