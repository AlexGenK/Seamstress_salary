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

ActiveRecord::Schema.define(version: 2022_05_22_093213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bonuses", force: :cascade do |t|
    t.date "date"
    t.integer "sum_prod"
    t.integer "sum_ts"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "executions", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "sum"
    t.decimal "time"
    t.bigint "work_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "operation_id"
    t.string "operation_number"
    t.string "operation_name"
    t.decimal "operation_time", precision: 5, scale: 3
    t.decimal "operation_cost", precision: 7, scale: 3
    t.index ["work_id"], name: "index_executions_on_work_id"
  end

  create_table "factors", force: :cascade do |t|
    t.integer "min"
    t.integer "max"
    t.decimal "value", precision: 4, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "models", force: :cascade do |t|
    t.string "sewing"
    t.text "name"
    t.string "number"
    t.integer "cost", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "operations", force: :cascade do |t|
    t.string "number"
    t.text "name"
    t.string "kind"
    t.integer "category"
    t.decimal "time", precision: 5, scale: 3
    t.decimal "cost", precision: 7, scale: 3
    t.bigint "model_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["model_id"], name: "index_operations_on_model_id"
  end

  create_table "personals", force: :cascade do |t|
    t.string "user_name"
    t.integer "report_time"
    t.integer "timesheet_time"
    t.integer "execution"
    t.decimal "factor", precision: 4, scale: 2
    t.bigint "bonus_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bonus_id"], name: "index_personals_on_bonus_id"
  end

  create_table "productions", force: :cascade do |t|
    t.string "user_name"
    t.date "date"
    t.decimal "sum", precision: 10, scale: 3
    t.decimal "time", precision: 10, scale: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "team"
  end

  create_table "ranks", force: :cascade do |t|
    t.string "sewing"
    t.integer "category"
    t.integer "cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "timesheets", force: :cascade do |t|
    t.date "date"
    t.integer "sum"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.boolean "admin_role", default: false
    t.boolean "worker_role", default: true
    t.string "team"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.integer "time"
    t.string "user_name"
    t.bigint "timesheet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["timesheet_id"], name: "index_visits_on_timesheet_id"
  end

  create_table "works", force: :cascade do |t|
    t.decimal "sum", precision: 10, scale: 3
    t.decimal "time", precision: 10, scale: 3
    t.bigint "production_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "model_id"
    t.text "model_nname"
    t.string "model_number"
    t.index ["production_id"], name: "index_works_on_production_id"
  end

  add_foreign_key "executions", "works"
  add_foreign_key "operations", "models"
  add_foreign_key "personals", "bonuses"
  add_foreign_key "visits", "timesheets"
  add_foreign_key "works", "productions"
end
