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

ActiveRecord::Schema.define(version: 6) do

  create_table "companies", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.string "picture"
    t.string "website"
    t.string "address"
    t.string "industry"
    t.text "description"
    t.string "directory_code"
    t.string "status", default: "no active"
    t.string "state", default: "new"
    t.string "worker_archive_status", default: "none"
    t.string "worker_publish_status", default: "none"
    t.string "worker_log"
    t.boolean "archive_ready", default: false, null: false
    t.integer "count_files", default: 0
    t.integer "shares_count", default: 10, null: false
    t.integer "share_in_minutes", default: 0, null: false
    t.integer "share_current", default: 0, null: false
    t.datetime "next_publication_date"
    t.integer "data_size", default: 0
    t.integer "data_size_published", default: 0
    t.date "published_date"
    t.integer "published_perc", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uuid"], name: "index_companies_on_uuid", unique: true
  end

  create_table "company_files", force: :cascade do |t|
    t.integer "company_id"
    t.string "uuid", null: false
    t.string "filename"
    t.string "filepath"
    t.float "filesize"
    t.string "mime_group"
    t.string "mime_type"
    t.boolean "published", default: false, null: false
    t.datetime "published_datetime"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_files_on_company_id"
    t.index ["uuid"], name: "index_company_files_on_uuid", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.string "user_name"
    t.string "user_surname"
    t.string "title"
    t.string "company"
    t.string "email"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "panel_configs", force: :cascade do |t|
    t.text "about_desc"
    t.text "contact_desc"
    t.text "home_head_title"
    t.text "home_head_desc"
    t.text "home_pre_release_desc"
    t.text "home_releasing_desc"
    t.text "home_released_desc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "press_releases", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "title", null: false
    t.text "content"
    t.string "picture"
    t.boolean "published", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password"
    t.string "password_hash"
    t.boolean "admin", default: false, null: false
    t.boolean "is_active", default: false, null: false
    t.string "token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
