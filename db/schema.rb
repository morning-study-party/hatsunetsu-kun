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

ActiveRecord::Schema.define(version: 2022_08_28_142533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_hours", force: :cascade do |t|
    t.string "open_at", null: false
    t.string "close_at", null: false
    t.integer "meridian", default: 0, null: false
    t.integer "day_of_week", default: 0, null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hospital_id"], name: "index_business_hours_on_hospital_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name", null: false
    t.text "notification"
    t.integer "primary_care_doctor", default: 0, null: false
    t.string "address", null: false
    t.integer "holiday_support", default: 0, null: false
    t.float "latitude", null: false
    t.float "longitud", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "contact", null: false
  end

  create_table "inspection_types", force: :cascade do |t|
    t.integer "pcr", default: 0, null: false
    t.integer "qualitative_antigen_test", default: 0, null: false
    t.integer "quantitative_inspection", default: 0, null: false
    t.bigint "hospital_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hospital_id"], name: "index_inspection_types_on_hospital_id", unique: true
  end

  create_table "target_groups", force: :cascade do |t|
    t.integer "pregnant", default: 0, null: false
    t.integer "someone_who_has_had_close_contact", default: 0, null: false
    t.integer "child", default: 0, null: false
    t.bigint "hospital_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hospital_id"], name: "index_target_groups_on_hospital_id", unique: true
  end

  add_foreign_key "business_hours", "hospitals"
  add_foreign_key "inspection_types", "hospitals"
  add_foreign_key "target_groups", "hospitals"
end
