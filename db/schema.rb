# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180118212232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string "name", null: false
    t.string "shortname", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shortname"], name: "index_agencies_on_shortname", unique: true
  end

  create_table "applicant_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "applicant_types_grants", force: :cascade do |t|
    t.bigint "grant_id", null: false
    t.bigint "applicant_type_id", null: false
    t.index ["applicant_type_id"], name: "index_applicant_types_grants_on_applicant_type_id"
    t.index ["grant_id"], name: "index_applicant_types_grants_on_grant_id"
  end

  create_table "deadlines", force: :cascade do |t|
    t.bigint "grant_id", null: false
    t.datetime "date"
    t.string "item_due"
    t.string "notes", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_deadlines_on_date"
    t.index ["grant_id"], name: "index_deadlines_on_grant_id"
    t.index ["item_due"], name: "index_deadlines_on_item_due"
  end

  create_table "grants", force: :cascade do |t|
    t.bigint "agency_id", null: false
    t.bigint "user_id", null: false
    t.string "title"
    t.string "url", null: false
    t.string "time_zone"
    t.string "sponsor"
    t.string "amount"
    t.text "residency"
    t.text "activity_location"
    t.text "body"
    t.boolean "dirty", default: true, null: false
    t.integer "remote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_grants_on_agency_id"
    t.index ["created_at"], name: "index_grants_on_created_at"
    t.index ["dirty"], name: "index_grants_on_dirty"
    t.index ["remote_id"], name: "index_grants_on_remote_id"
    t.index ["url"], name: "index_grants_on_url", unique: true
    t.index ["user_id"], name: "index_grants_on_user_id"
  end

  create_table "que_jobs", primary_key: ["queue", "priority", "run_at", "job_id"], force: :cascade, comment: "3" do |t|
    t.integer "priority", limit: 2, default: 100, null: false
    t.datetime "run_at", default: -> { "now()" }, null: false
    t.bigserial "job_id", null: false
    t.text "job_class", null: false
    t.json "args", default: [], null: false
    t.integer "error_count", default: 0, null: false
    t.text "last_error"
    t.text "queue", default: "", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "grant_id", null: false
    t.bigint "user_id", null: false
    t.string "status", null: false
    t.text "submitter_notes"
    t.text "reviewer_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_reviews_on_created_at"
    t.index ["grant_id"], name: "index_reviews_on_grant_id"
    t.index ["status"], name: "index_reviews_on_status"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "applicant_types_grants", "applicant_types"
  add_foreign_key "applicant_types_grants", "grants"
  add_foreign_key "deadlines", "grants"
  add_foreign_key "grants", "agencies"
  add_foreign_key "grants", "users"
  add_foreign_key "reviews", "grants"
  add_foreign_key "reviews", "users"
end
