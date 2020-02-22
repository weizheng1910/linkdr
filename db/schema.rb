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

ActiveRecord::Schema.define(version: 2020_02_22_081018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidates", force: :cascade do |t|
    t.string "given_name"
    t.string "family_name"
    t.integer "years_of_experience"
    t.string "expected_salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_candidate_id"
    t.text "bio"
    t.string "resume_url"
    t.integer "views", default: 0
  end

  create_table "candidates_skills", force: :cascade do |t|
    t.bigint "candidate_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_candidates_skills_on_candidate_id"
    t.index ["skill_id"], name: "index_candidates_skills_on_skill_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "industry"
    t.string "size"
    t.bigint "user_company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "views", default: 0
    t.string "avatar_url"
    t.index ["user_company_id"], name: "index_companies_on_user_company_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "offered_salary"
    t.string "country"
    t.bigint "company_id"
    t.integer "views", default: 0
    t.index ["company_id"], name: "index_jobs_on_company_id"
  end

  create_table "jobs_skills", force: :cascade do |t|
    t.bigint "job_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_jobs_skills_on_job_id"
    t.index ["skill_id"], name: "index_jobs_skills_on_skill_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "job_id"
    t.bigint "candidate_id"
    t.boolean "job_like"
    t.boolean "candidate_like"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_matches_on_candidate_id"
    t.index ["job_id"], name: "index_matches_on_job_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_candidates", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_user_candidates_on_confirmation_token", unique: true
    t.index ["email"], name: "index_user_candidates_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_candidates_on_reset_password_token", unique: true
  end

  create_table "user_companies", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_user_companies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_companies_on_reset_password_token", unique: true
  end

  add_foreign_key "matches", "candidates"
  add_foreign_key "matches", "jobs"
end
