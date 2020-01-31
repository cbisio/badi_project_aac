# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_30_120849) do

  # These are extensions that must be enabled in order to support this database

  enable_extension "plpgsql"


  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "extras", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "extras_rooms", id: false, force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "extra_id", null: false
    t.index ["extra_id", "room_id"], name: "index_extras_rooms_on_extra_id_and_room_id"
    t.index ["room_id", "extra_id"], name: "index_extras_rooms_on_room_id_and_extra_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "url"
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "room_id", null: false
    t.index ["room_id"], name: "index_photos_on_room_id"
  end

  create_table "room_views", force: :cascade do |t|
    t.string "ip"
    t.bigint "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_room_views_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.boolean "bills_included"
    t.integer "deposit"
    t.integer "room_size"
    t.integer "property_size"
    t.text "description"
    t.float "latitude"
    t.float "longitude"
    t.integer "num_visits"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.string "address"
    t.bigint "city_id", null: false
    t.string "currency"
    t.index ["city_id"], name: "index_rooms_on_city_id"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.date "birth_date"
    t.string "gender"
    t.text "about"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "photos", "rooms"
  add_foreign_key "room_views", "rooms"
  add_foreign_key "rooms", "cities"
  add_foreign_key "rooms", "users"
end
