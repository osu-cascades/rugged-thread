# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_08_230710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "brands_item_types", id: false, force: :cascade do |t|
    t.bigint "item_type_id", null: false
    t.bigint "brand_id", null: false
  end

  create_table "complication_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "complications", force: :cascade do |t|
    t.string "time"
    t.float "charge"
    t.bigint "repair_id", null: false
    t.bigint "complication_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["complication_type_id"], name: "index_complications_on_complication_type_id"
    t.index ["repair_id"], name: "index_complications_on_repair_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "business_name"
    t.string "phone_number"
    t.string "email_address"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoice_items", force: :cascade do |t|
    t.text "description"
    t.bigint "invoice_id", null: false
    t.bigint "item_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
    t.index ["item_type_id"], name: "index_invoice_items_on_item_type_id"
  end

  create_table "invoice_items_repairs", id: false, force: :cascade do |t|
    t.bigint "invoice_item_id", null: false
    t.bigint "repair_id", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.float "invoice_estimate"
    t.float "invoice_total"
    t.string "intake_date"
    t.string "date_fulfilled"
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
  end

  create_table "item_types", force: :cascade do |t|
    t.string "name"
    t.string "component"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "repair_types", force: :cascade do |t|
    t.string "name"
    t.string "time_estimate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "repairs", force: :cascade do |t|
    t.float "charge"
    t.string "time_total"
    t.bigint "invoice_item_id", null: false
    t.bigint "repair_type_id", null: false
    t.bigint "technician_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_item_id"], name: "index_repairs_on_invoice_item_id"
    t.index ["repair_type_id"], name: "index_repairs_on_repair_type_id"
    t.index ["technician_id"], name: "index_repairs_on_technician_id"
  end

  create_table "technicians", force: :cascade do |t|
    t.string "name"
    t.string "skill_level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.text "repair_description"
    t.float "add_fee"
    t.string "technician_notes"
    t.string "work_status"
    t.bigint "technician_id", null: false
    t.bigint "invoice_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_id"], name: "index_tickets_on_invoice_id"
    t.index ["technician_id"], name: "index_tickets_on_technician_id"
  end

  add_foreign_key "complications", "complication_types"
  add_foreign_key "complications", "repairs"
  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoice_items", "item_types"
  add_foreign_key "invoices", "customers"
  add_foreign_key "repairs", "invoice_items"
  add_foreign_key "repairs", "repair_types"
  add_foreign_key "repairs", "technicians"
  add_foreign_key "tickets", "invoices"
  add_foreign_key "tickets", "technicians"
end
