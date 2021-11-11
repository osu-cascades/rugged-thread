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

ActiveRecord::Schema.define(version: 2021_11_11_225344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "quote"
    t.float "charge"
    t.text "notes"
    t.integer "invoice_number"
    t.bigint "invoice_id"
    t.string "number"
    t.string "item_type"
    t.index ["number"], name: "index_invoice_items_on_number", unique: true
  end

  create_table "invoices", force: :cascade do |t|
    t.float "invoice_total"
    t.string "intake_date"
    t.string "date_fulfilled"
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "notes"
    t.integer "number"
    t.integer "estimate_number"
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
    t.index ["number"], name: "index_invoices_on_number", unique: true
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

  create_table "repair_types", force: :cascade do |t|
    t.string "name"
    t.string "time_estimate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "number"
  end

  create_table "repairs", force: :cascade do |t|
    t.float "charge"
    t.string "time_total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "notes"
    t.integer "time"
    t.float "shop_rate"
    t.float "quote"
    t.string "item_number"
    t.string "number"
    t.string "technician_name"
    t.string "date"
    t.text "description"
    t.index ["number"], name: "index_repairs_on_number", unique: true
  end

  create_table "task_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "status"
    t.index ["name"], name: "index_task_types_on_name", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "time"
    t.string "tech_name"
    t.float "repair_charge"
    t.string "repair_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "task_type_name"
    t.string "technician_name"
    t.string "date"
  end

  create_table "technicians", force: :cascade do |t|
    t.string "name"
    t.string "skill_level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "status"
    t.index ["name"], name: "index_technicians_on_name", unique: true
  end

  create_table "tickets", force: :cascade do |t|
    t.text "repair_description"
    t.float "add_fee"
    t.string "technician_notes"
    t.string "work_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "material"
    t.string "request_date"
    t.string "order_type"
    t.integer "labor_charge"
    t.integer "material_charge"
    t.integer "estimate_number"
    t.float "discount"
    t.string "phone_number"
    t.string "intake_date"
    t.string "customer_name"
    t.integer "invoice_number"
    t.string "technician_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "complications", "complication_types"
  add_foreign_key "complications", "repairs"
  add_foreign_key "invoice_items", "invoices", column: "invoice_number", primary_key: "number"
  add_foreign_key "invoices", "customers"
  add_foreign_key "repairs", "invoice_items", column: "item_number", primary_key: "number"
  add_foreign_key "repairs", "technicians", column: "technician_name", primary_key: "name"
  add_foreign_key "tasks", "repairs", column: "repair_number", primary_key: "number"
  add_foreign_key "tasks", "task_types", column: "task_type_name", primary_key: "name"
  add_foreign_key "tasks", "technicians", column: "technician_name", primary_key: "name"
  add_foreign_key "tickets", "invoices", column: "invoice_number", primary_key: "number"
  add_foreign_key "tickets", "technicians", column: "technician_name", primary_key: "name"
end
