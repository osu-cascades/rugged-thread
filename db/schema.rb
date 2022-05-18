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

ActiveRecord::Schema[7.0].define(version: 2022_05_18_080533) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.integer "turn_around"
    t.integer "cost_share"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_accounts_on_discarded_at"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
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
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_brands_on_discarded_at"
  end

  create_table "complications", force: :cascade do |t|
    t.bigint "standard_complication_id", null: false
    t.bigint "repair_id", null: false
    t.integer "price_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repair_id"], name: "index_complications_on_repair_id"
    t.index ["standard_complication_id"], name: "index_complications_on_standard_complication_id"
  end

  create_table "customer_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customers_count", default: 0, null: false
    t.integer "turn_around", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_customer_types_on_discarded_at"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_type_id", null: false
    t.string "alternative_phone_number"
    t.string "billing_street_address"
    t.string "billing_city"
    t.string "billing_state"
    t.string "billing_zip_code"
    t.datetime "discarded_at"
    t.index ["customer_type_id"], name: "index_customers_on_customer_type_id"
    t.index ["discarded_at"], name: "index_customers_on_discarded_at"
  end

  create_table "discounts", force: :cascade do |t|
    t.bigint "standard_discount_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents"
    t.integer "percentage_amount"
    t.integer "position"
    t.index ["item_id"], name: "index_discounts_on_item_id"
    t.index ["standard_discount_id"], name: "index_discounts_on_standard_discount_id"
  end

  create_table "fees", force: :cascade do |t|
    t.bigint "standard_fee_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.integer "position"
    t.index ["item_id"], name: "index_fees_on_item_id"
    t.index ["standard_fee_id"], name: "index_fees_on_standard_fee_id"
  end

  create_table "inventory_items", force: :cascade do |t|
    t.integer "price_cents", default: 0, null: false
    t.bigint "repair_id", null: false
    t.bigint "standard_inventory_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repair_id"], name: "index_inventory_items_on_repair_id"
    t.index ["standard_inventory_item_id"], name: "index_inventory_items_on_standard_inventory_item_id"
  end

  create_table "item_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default", default: false
    t.datetime "discarded_at"
    t.index ["default"], name: "index_item_statuses_on_default", unique: true, where: "(\"default\" IS TRUE)"
    t.index ["discarded_at"], name: "index_item_statuses_on_discarded_at"
  end

  create_table "item_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_item_types_on_discarded_at"
  end

  create_table "items", force: :cascade do |t|
    t.date "due_date"
    t.string "notes"
    t.bigint "brand_id", null: false
    t.bigint "work_order_id", null: false
    t.bigint "item_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_status_id", null: false
    t.boolean "shipping"
    t.integer "position"
    t.index ["brand_id"], name: "index_items_on_brand_id"
    t.index ["item_status_id"], name: "index_items_on_item_status_id"
    t.index ["item_type_id"], name: "index_items_on_item_type_id"
    t.index ["work_order_id"], name: "index_items_on_work_order_id"
  end

  create_table "quote_requests", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone_number", null: false
    t.string "promo_code"
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "shipping", null: false
    t.bigint "item_type_id", null: false
    t.bigint "brand_id", null: false
    t.integer "status", default: 0, null: false
    t.index ["brand_id"], name: "index_quote_requests_on_brand_id"
    t.index ["item_type_id"], name: "index_quote_requests_on_item_type_id"
  end

  create_table "repairs", force: :cascade do |t|
    t.bigint "standard_repair_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.integer "price_cents", default: 0, null: false
    t.integer "level", default: 1, null: false
    t.integer "position"
    t.index ["item_id"], name: "index_repairs_on_item_id"
    t.index ["standard_repair_id"], name: "index_repairs_on_standard_repair_id"
  end

  create_table "shop_parameters", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_shop_parameters_on_discarded_at"
  end

  create_table "special_order_items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price_cents", default: 0, null: false
    t.bigint "repair_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ordering_fee_price_cents", default: 0, null: false
    t.integer "freight_fee_price_cents", default: 0, null: false
    t.index ["repair_id"], name: "index_special_order_items_on_repair_id"
  end

  create_table "standard_complications", force: :cascade do |t|
    t.string "name"
    t.integer "price_cents", default: 0, null: false
    t.bigint "standard_repair_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_standard_complications_on_discarded_at"
    t.index ["standard_repair_id"], name: "index_standard_complications_on_standard_repair_id"
  end

  create_table "standard_discounts", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "percentage_amount"
    t.integer "price_cents"
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_standard_discounts_on_discarded_at"
  end

  create_table "standard_fees", force: :cascade do |t|
    t.text "name"
    t.integer "price_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_standard_fees_on_discarded_at"
  end

  create_table "standard_inventory_items", force: :cascade do |t|
    t.string "name"
    t.string "sku"
    t.integer "price_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_standard_inventory_items_on_discarded_at"
  end

  create_table "standard_repairs", force: :cascade do |t|
    t.string "name"
    t.string "method"
    t.text "description"
    t.integer "price_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level", default: 1, null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_standard_repairs_on_discarded_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.date "end_date"
    t.float "efficiency"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "role", default: 0, null: false
    t.integer "status", default: 1, null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_orders", force: :cascade do |t|
    t.date "in_date"
    t.boolean "shipping"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id", null: false
    t.bigint "creator_id", null: false
    t.date "due_date", null: false
    t.string "number", null: false
    t.datetime "discarded_at"
    t.index ["creator_id"], name: "index_work_orders_on_creator_id"
    t.index ["customer_id"], name: "index_work_orders_on_customer_id"
    t.index ["discarded_at"], name: "index_work_orders_on_discarded_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "complications", "repairs"
  add_foreign_key "complications", "standard_complications"
  add_foreign_key "customers", "customer_types"
  add_foreign_key "discounts", "items"
  add_foreign_key "discounts", "standard_discounts"
  add_foreign_key "fees", "items"
  add_foreign_key "fees", "standard_fees"
  add_foreign_key "inventory_items", "repairs"
  add_foreign_key "inventory_items", "standard_inventory_items"
  add_foreign_key "items", "brands"
  add_foreign_key "items", "item_statuses"
  add_foreign_key "items", "item_types"
  add_foreign_key "items", "work_orders"
  add_foreign_key "quote_requests", "brands"
  add_foreign_key "quote_requests", "item_types"
  add_foreign_key "repairs", "items"
  add_foreign_key "repairs", "standard_repairs"
  add_foreign_key "special_order_items", "repairs"
  add_foreign_key "standard_complications", "standard_repairs"
  add_foreign_key "work_orders", "customers"
  add_foreign_key "work_orders", "users", column: "creator_id"
end
