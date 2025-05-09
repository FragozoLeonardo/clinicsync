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

ActiveRecord::Schema[8.0].define(version: 2025_04_20_202248) do
# These are extensions that must be enabled in order to support this database
enable_extension "citext"
enable_extension "pg_catalog.plpgsql"

create_table "account_login_change_keys", force: :cascade do |t|
  t.string "key", null: false
  t.string "login", null: false
  t.datetime "deadline", null: false
end

create_table "account_password_reset_keys", force: :cascade do |t|
  t.string "key", null: false
  t.datetime "deadline", null: false
  t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
end

create_table "account_remember_keys", force: :cascade do |t|
  t.string "key", null: false
  t.datetime "deadline", null: false
end

create_table "account_verification_keys", force: :cascade do |t|
  t.string "key", null: false
  t.datetime "requested_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
end

create_table "accounts", force: :cascade do |t|
  t.integer "status", default: 1, null: false
  t.citext "email", null: false
  t.string "password_hash"
  t.string "type", default: "User", null: false
  t.index ["email"], name: "index_accounts_on_email", unique: true, where: "(status = ANY (ARRAY[1, 2]))"
  t.check_constraint "email ~ '^[^,;@ \r\n]+@[^,@; \r\n]+.[^,@; \r\n]+$'::citext", name: "valid_email"
end

create_table "sessions", force: :cascade do |t|
  t.bigint "user_id", null: false
  t.string "ip_address"
  t.string "user_agent"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.index ["user_id"], name: "index_sessions_on_user_id"
end

create_table "users", force: :cascade do |t|
  t.string "email_address", null: false
  t.string "password_digest", null: false
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.string "type", default: "Admin", null: false
  t.index ["email_address"], name: "index_users_on_email_address", unique: true
end

add_foreign_key "account_login_change_keys", "accounts", column: "id"
add_foreign_key "account_password_reset_keys", "accounts", column: "id"
add_foreign_key "account_remember_keys", "accounts", column: "id"
add_foreign_key "account_verification_keys", "accounts", column: "id"
add_foreign_key "sessions", "users"
end
