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

ActiveRecord::Schema[7.0].define(version: 2023_08_16_173233) do
  create_table "car_models", force: :cascade do |t|
    t.string "identifier", null: false
    t.integer "car_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_type_id"], name: "index_car_models_on_car_type_id"
  end

  create_table "car_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type_name", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "railroad", null: false
    t.string "local"
    t.string "routingTag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shorthand", null: false
  end

  create_table "order_rules", force: :cascade do |t|
    t.string "commodity"
    t.integer "dropoff_state", null: false
    t.integer "pickup_state", null: false
    t.integer "max_cars", null: false
    t.integer "current_cars", default: 0
    t.datetime "last_order"
    t.datetime "last_delivery"
    t.integer "hazmat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id", null: false
    t.integer "car_type_id", null: false
    t.index ["car_type_id"], name: "index_order_rules_on_car_type_id"
    t.index ["customer_id"], name: "index_order_rules_on_customer_id"
  end

  add_foreign_key "car_models", "car_types"
  add_foreign_key "order_rules", "car_types"
  add_foreign_key "order_rules", "customers"
end
