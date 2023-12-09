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

ActiveRecord::Schema.define(version: 2023_12_09_003813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tag", limit: 50
  end

  create_table "frame_alerts", force: :cascade do |t|
    t.integer "quantity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "frames", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "color", limit: 50, null: false
    t.string "kind", limit: 50, null: false
    t.integer "inventory", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "frame_alert_id", null: false
    t.index ["frame_alert_id"], name: "index_frames_on_frame_alert_id"
  end

  create_table "product_alerts", force: :cascade do |t|
    t.integer "quantity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "image", null: false
    t.integer "stock", null: false
    t.bigint "category_id", null: false
    t.bigint "frame_id", null: false
    t.bigint "product_alert_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["frame_id"], name: "index_products_on_frame_id"
    t.index ["product_alert_id"], name: "index_products_on_product_alert_id"
  end

  add_foreign_key "frames", "frame_alerts"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "frames"
  add_foreign_key "products", "product_alerts"
end
