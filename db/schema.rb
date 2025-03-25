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

ActiveRecord::Schema[7.1].define(version: 2025_03_18_144731) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "mpaa_rating", ["G", "PG", "PG-13", "R", "NC-17"]

  create_table "actor", primary_key: "actor_id", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 45, null: false
    t.string "last_name", limit: 45, null: false
    t.datetime "last_update", precision: nil, default: -> { "now()" }, null: false
    t.index ["last_name"], name: "idx_actor_last_name"
  end

  create_table "address", primary_key: "address_id", id: :serial, force: :cascade do |t|
    t.string "address", limit: 50, null: false
    t.string "address2", limit: 50
    t.string "district", limit: 20, null: false
    t.integer "city_id", limit: 2, null: false
    t.string "postal_code", limit: 10
    t.string "phone", limit: 20, null: false
    t.datetime "last_update", precision: nil, default: -> { "now()" }, null: false
  end

  create_table "customer", primary_key: "customer_id", id: :serial, force: :cascade do |t|
    t.integer "store_id", limit: 2, null: false
    t.string "first_name", limit: 45, null: false
    t.string "last_name", limit: 45, null: false
    t.string "email", limit: 50
    t.integer "address_id", limit: 2, null: false
    t.boolean "activebool", default: true, null: false
    t.date "create_date", default: -> { "now()" }, null: false
    t.datetime "last_update", precision: nil, default: -> { "now()" }
    t.integer "active"
    t.index ["last_name"], name: "idx_customer_last_name"
  end

  create_table "film", primary_key: "film_id", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.text "description"
    t.integer "release_year"
    t.integer "language_id", limit: 2, null: false
    t.integer "rental_duration", limit: 2, default: 3, null: false
    t.decimal "rental_rate", precision: 4, scale: 2, default: "4.99", null: false
    t.integer "length", limit: 2
    t.decimal "replacement_cost", precision: 5, scale: 2, default: "19.99", null: false
    t.enum "rating", default: "G", enum_type: "mpaa_rating"
    t.datetime "last_update", precision: nil, default: -> { "now()" }, null: false
    t.index ["title"], name: "idx_film_title"
  end

  create_table "inventory", primary_key: "inventory_id", id: :serial, force: :cascade do |t|
    t.integer "film_id", limit: 2, null: false
    t.integer "store_id", limit: 2, null: false
    t.datetime "last_update", precision: nil, default: -> { "now()" }, null: false
  end

  create_table "language", primary_key: "language_id", id: :serial, force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.datetime "last_update", precision: nil, default: -> { "now()" }, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "customer", "address", primary_key: "address_id", name: "customer_address_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film", "language", primary_key: "language_id", name: "film_language_id_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "inventory", "film", primary_key: "film_id", name: "inventory_film_id_fkey", on_update: :cascade, on_delete: :restrict
end
