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

ActiveRecord::Schema[7.1].define(version: 2023_12_26_234500) do
  create_table "car_models", force: :cascade do |t|
    t.string "FQDN"
    t.integer "car_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_type_id"], name: "index_car_models_on_car_type_id"
  end

  create_table "car_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "routing_tag"
    t.string "destinations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_rules", force: :cascade do |t|
    t.string "commodity"
    t.integer "max_cars"
    t.boolean "is_loaded"
    t.integer "manutention_time"
    t.integer "customer_id"
    t.integer "car_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_type_id"], name: "index_order_rules_on_car_type_id"
    t.index ["customer_id"], name: "index_order_rules_on_customer_id"
  end

  add_foreign_key "car_models", "car_types"
  add_foreign_key "order_rules", "car_types"
  add_foreign_key "order_rules", "customers"
end
