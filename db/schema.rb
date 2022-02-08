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

ActiveRecord::Schema.define(version: 2022_02_08_031018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.integer "turn_around"
    t.integer "cost_share"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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

  create_table "customer_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "business_name"
    t.string "phone_number"
    t.string "email_address"
    t.string "shipping_street_address"
    t.string "shipping_city"
    t.string "shipping_state"
    t.string "shipping_zip_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "customer_type_id", null: false
    t.string "alternative_phone_number"
    t.string "billing_street_address"
    t.string "billing_city"
    t.string "billing_state"
    t.string "billing_zip_code"
    t.index ["customer_type_id"], name: "index_customers_on_customer_type_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "percentage_amount"
    t.integer "dollar_amount"
  end

  create_table "fees", force: :cascade do |t|
    t.text "name"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoice_items", force: :cascade do |t|
    t.text "description"
    t.bigint "invoice_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number"
    t.float "quote"
    t.float "charge"
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
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
    t.text "notes"
    t.integer "number"
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
  end

  create_table "item_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "default", default: false
    t.index ["default"], name: "index_item_statuses_on_default", unique: true, where: "(\"default\" IS TRUE)"
  end

  create_table "item_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.date "due_date"
    t.integer "estimate"
    t.integer "labor_estimate"
    t.string "notes"
    t.bigint "brand_id", null: false
    t.bigint "work_order_id", null: false
    t.bigint "item_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "item_status_id", null: false
    t.index ["brand_id"], name: "index_items_on_brand_id"
    t.index ["item_status_id"], name: "index_items_on_item_status_id"
    t.index ["item_type_id"], name: "index_items_on_item_type_id"
    t.index ["work_order_id"], name: "index_items_on_work_order_id"
  end

  create_table "quote_requests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.string "item_type"
    t.string "brand"
    t.string "will_mail_item"
    t.string "promo_code"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "repairs", force: :cascade do |t|
    t.bigint "standard_repair_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "notes"
    t.integer "price"
    t.index ["item_id"], name: "index_repairs_on_item_id"
    t.index ["standard_repair_id"], name: "index_repairs_on_standard_repair_id"
  end

  create_table "shop_parameters", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "standard_repairs", force: :cascade do |t|
    t.string "name"
    t.string "method"
    t.text "description"
    t.integer "charge"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "task_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "time"
    t.integer "number"
    t.bigint "task_type_id", null: false
    t.bigint "technician_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_type_id"], name: "index_tasks_on_task_type_id"
    t.index ["technician_id"], name: "index_tasks_on_technician_id"
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

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.date "end_date"
    t.float "efficiency"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: 6
    t.datetime "last_sign_in_at", precision: 6
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "role", default: 0, null: false
    t.integer "status", default: 1, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_orders", force: :cascade do |t|
    t.date "in_date"
    t.boolean "shipping"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "customer_id", null: false
    t.bigint "creator_id", null: false
    t.index ["creator_id"], name: "index_work_orders_on_creator_id"
    t.index ["customer_id"], name: "index_work_orders_on_customer_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "customers", "customer_types"
  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoices", "customers"
  add_foreign_key "items", "brands"
  add_foreign_key "items", "item_statuses"
  add_foreign_key "items", "item_types"
  add_foreign_key "items", "work_orders"
  add_foreign_key "repairs", "items"
  add_foreign_key "repairs", "standard_repairs"
  add_foreign_key "tasks", "task_types"
  add_foreign_key "tasks", "technicians"
  add_foreign_key "tickets", "invoices"
  add_foreign_key "tickets", "technicians"
  add_foreign_key "work_orders", "customers"
  add_foreign_key "work_orders", "users", column: "creator_id"
end
