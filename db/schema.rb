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

ActiveRecord::Schema.define(version: 2019_09_16_230052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "contestants", force: :cascade do |t|
    t.string "name_english"
    t.string "name_native"
    t.string "headshot_url"
    t.string "bodyshot_url"
    t.string "profile_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contests", force: :cascade do |t|
    t.string "name_native"
    t.string "name_english"
    t.string "url"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_size"
  end

  create_table "group_members", force: :cascade do |t|
    t.bigint "contestant_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contestant_id"], name: "index_group_members_on_contestant_id"
    t.index ["group_id"], name: "index_group_members_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "contest_id"
    t.bigint "user_id"
    t.string "name"
    t.integer "center_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contest_id"], name: "index_groups_on_contest_id"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "performances", force: :cascade do |t|
    t.bigint "contestant_id"
    t.string "youtube_video_id"
    t.string "name_native"
    t.string "name_english"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contestant_id"], name: "index_performances_on_contestant_id"
  end

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, default: nil, force: :cascade do |t|
    t.string "auth_name", limit: 256
    t.integer "auth_srid"
    t.string "srtext", limit: 2048
    t.string "proj4text", limit: 2048
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_group_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "performances", "contestants"
end
