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

ActiveRecord::Schema[7.1].define(version: 2024_01_01_234707) do
  create_table "car_models", force: :cascade do |t|
    t.string "FQDN"
    t.integer "car_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "empty_weight"
    t.decimal "max_weight"
    t.decimal "length"
    t.decimal "coupler_offset"
    t.decimal "bolster_length"
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
    t.integer "local_train_id"
    t.index ["local_train_id"], name: "index_customers_on_local_train_id"
  end

  create_table "local_trains", force: :cascade do |t|
    t.string "name", null: false
    t.string "routing_tag", null: false
    t.integer "yard_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["yard_id"], name: "index_local_trains_on_yard_id"
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

  create_table "orders", force: :cascade do |t|
    t.integer "ordered_count"
    t.integer "status"
    t.string "routing_tag"
    t.integer "train_id"
    t.integer "track_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_rule_id", null: false
    t.index ["order_rule_id"], name: "index_orders_on_order_rule_id"
    t.index ["track_id"], name: "index_orders_on_track_id"
    t.index ["train_id"], name: "index_orders_on_train_id"
  end

  create_table "spawn_points", force: :cascade do |t|
    t.integer "track_id", null: false
    t.boolean "allow_supply_train", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_spawn_points_on_track_id"
  end

  create_table "supply_train_blueprints", force: :cascade do |t|
    t.string "routing_tag", null: false
    t.string "destination"
    t.integer "avg_cars", null: false
    t.integer "max_length", null: false
    t.integer "max_weight", null: false
    t.integer "spawn_point_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spawn_point_id"], name: "index_supply_train_blueprints_on_spawn_point_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name"
    t.integer "length"
    t.integer "yard_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["yard_id"], name: "index_tracks_on_yard_id"
  end

  create_table "trains", force: :cascade do |t|
    t.string "routing_tag"
    t.integer "length"
    t.integer "weigth"
    t.integer "track_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_trains_on_track_id"
  end

  create_table "yards", force: :cascade do |t|
    t.string "name"
    t.string "routing_tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "yard_type"
    t.integer "yard_id"
    t.index ["yard_id"], name: "index_yards_on_yard_id"
  end

  add_foreign_key "car_models", "car_types"
  add_foreign_key "customers", "local_trains"
  add_foreign_key "local_trains", "yards"
  add_foreign_key "order_rules", "car_types"
  add_foreign_key "order_rules", "customers"
  add_foreign_key "orders", "order_rules"
  add_foreign_key "orders", "tracks"
  add_foreign_key "orders", "trains"
  add_foreign_key "spawn_points", "tracks"
  add_foreign_key "supply_train_blueprints", "spawn_points"
  add_foreign_key "tracks", "yards"
  add_foreign_key "trains", "tracks"
end
