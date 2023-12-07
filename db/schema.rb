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

ActiveRecord::Schema.define(version: 2023_12_07_055405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "frame_alerts", force: :cascade do |t|
    t.integer "quantity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "frames", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "color", limit: 50, null: false
    t.string "type", limit: 50, null: false
    t.integer "inventory", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "frame_alerts_id", null: false
    t.index ["frame_alerts_id"], name: "index_frames_on_frame_alerts_id"
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
    t.bigint "textile_categories_id", null: false
    t.bigint "frames_id", null: false
    t.bigint "product_alerts_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["frames_id"], name: "index_products_on_frames_id"
    t.index ["product_alerts_id"], name: "index_products_on_product_alerts_id"
    t.index ["textile_categories_id"], name: "index_products_on_textile_categories_id"
  end

  create_table "textile_categories", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "frames", "frame_alerts", column: "frame_alerts_id"
  add_foreign_key "products", "frames", column: "frames_id"
  add_foreign_key "products", "product_alerts", column: "product_alerts_id"
  add_foreign_key "products", "textile_categories", column: "textile_categories_id"
end
