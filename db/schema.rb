# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141205221543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "executives", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "strat_exec_constituent_type"
    t.string   "prefix"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "suffix"
    t.string   "email"
    t.string   "alt_email"
    t.string   "mobile_tel"
    t.string   "mobile_carrier"
    t.string   "office_tel"
    t.string   "home_tel"
    t.string   "fax"
    t.string   "exec_web_url"
    t.string   "exec_description"
    t.string   "address_street"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "demog_spousal_status"
    t.string   "spouse_name"
    t.string   "demog_gender"
    t.string   "demog_ethnicity"
    t.string   "country_of_origin"
    t.string   "demog_sexual_orientation"
    t.string   "social_twitter"
    t.string   "social_linkedin"
    t.string   "social_facebook"
    t.string   "social_googleplus"
    t.string   "social_youtube"
    t.string   "social_pinterest"
    t.string   "social_instagram"
    t.string   "social_photo"
    t.string   "social_blog"
    t.string   "social_platform_dominant"
    t.string   "certifications"
    t.string   "picture_file_name"
    t.string   "picture_file_type"
    t.string   "is_verified_by_staff"
    t.string   "is_verified_by_thirdparty"
    t.string   "exec_comments_on_self"
    t.string   "staff_comments_on_exec"
    t.integer  "created_by_exec_id"
    t.string   "is_active"
    t.string   "is_admin"
    t.boolean  "is_user"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "organizations", force: true do |t|
    t.string   "org_name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "crunchbase_uuid"
    t.string   "org_types_id"
    t.string   "sector_type"
    t.string   "strat_org_constituent_type"
    t.string   "description"
    t.string   "web_url"
    t.string   "parent_or_child_org"
    t.integer  "parent_org_id"
    t.string   "size_revenue"
    t.string   "size_employees_structured"
    t.string   "vision"
    t.string   "mission"
    t.string   "goals"
    t.string   "values"
    t.string   "motto_or_tagline"
    t.string   "hq_address_street"
    t.string   "hq_address_city"
    t.string   "hq_address_state"
    t.string   "hq_address_zip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "hq_telephone"
    t.string   "hq_email"
    t.string   "region_headquartered_in"
    t.datetime "date_org_founded"
    t.string   "social_twitter"
    t.string   "social_linkedin"
    t.string   "social_facebook"
    t.string   "social_googleplus"
    t.string   "social_youtube"
    t.string   "social_platform_dominant"
    t.string   "org_special_designations"
    t.string   "logo_file_name"
    t.string   "logo_file_type"
    t.string   "is_verified_by_staff"
    t.string   "is_verified_by_thirdparty"
    t.string   "exec_comments_on_org"
    t.string   "staff_comments_on_org"
    t.integer  "created_by_exec_id"
    t.string   "certifications"
    t.string   "source_original"
    t.string   "is_active"
  end

  create_table "relationships", force: true do |t|
    t.integer  "executive_id"
    t.integer  "organization_id"
    t.string   "relationship_type"
    t.string   "job_title"
    t.string   "is_relationship_current"
    t.string   "is_relationship_primary"
    t.integer  "start_date_month"
    t.integer  "start_date_year"
    t.integer  "end_date_month"
    t.integer  "end_date_year"
    t.string   "is_verified_by_org"
    t.string   "is_verified_by_staff"
    t.string   "is_verified_by_thirdparty"
    t.integer  "created_by_exec_id"
    t.string   "exec_comments_on_relationship"
    t.string   "staff_comments_on_relationship"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "relationships", ["executive_id"], name: "index_relationships_on_executive_id", using: :btree
  add_index "relationships", ["organization_id"], name: "index_relationships_on_organization_id", using: :btree

end
