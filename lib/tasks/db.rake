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
      # repair_nums = json[num]['Repair No']
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

      if !RepairType.exists?(number: repair_type_nums)
        RepairType.create!(
          number: repair_type_nums
        )
      end
      
      if !Invoice.exists?(number: invoice_nums)
        Invoice.create!(
          id: num,
          customer_id: num,
          invoice_estimate: invoice_ests,
          intake_date: invoice_intakes,
          number: invoice_nums,
        )
      end

      if !Technician.exists?(name: tech_names)
        Technician.create!(
          name: tech_names
        )
      end
      
      if !InvoiceItem.exists?(number: item_type_num)
        InvoiceItem.create!(
          id: num,
          number: item_type_num,
          invoice_number: invoice_nums,
          quote: item_quotes.to_i.to_f,
          charge: item_charges.to_i.to_f
        )
      end

      if !Repair.exists?(number: repair_type_nums)
        Repair.create!(
          number: repair_type_nums.to_s,
          date: repair_dates,
          charge: repair_charges.to_i.to_f,
          time_total: repair_times.to_s,
          time: repair_times.to_s,
          shop_rate: shop_rates.to_i.to_f,
        )
      end

      if !TaskType.exists?(name: tasks)
        TaskType.create!(
          name: tasks
        )
      end


      Task.create!(
        time: task_time.to_i,
        repair_number: repair_type_nums.to_s,
        tech_name: solo_techs,
        repair_charge: first_repair_charge,
        task_type_name: tasks,
        technician_name: tech_names
      )
    end
  end
end