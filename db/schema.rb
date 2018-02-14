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

ActiveRecord::Schema.define(version: 20180211113104) do

  create_table "albums", force: :cascade do |t|
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "album_img_file_name",    limit: 255
    t.string   "album_img_content_type", limit: 255
    t.integer  "album_img_file_size",    limit: 4
    t.datetime "album_img_updated_at"
    t.integer  "category",               limit: 4,   default: 0
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "bookmarkee_id",   limit: 4
    t.string   "bookmarkee_type", limit: 255
    t.integer  "bookmarker_id",   limit: 4
    t.string   "bookmarker_type", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "bookmarks", ["bookmarkee_id", "bookmarkee_type", "bookmarker_id", "bookmarker_type"], name: "bookmarks_bookmarkee_bookmarker_idx", unique: true, using: :btree
  add_index "bookmarks", ["bookmarkee_id", "bookmarkee_type"], name: "bookmarks_bookmarkee_idx", using: :btree
  add_index "bookmarks", ["bookmarker_id", "bookmarker_type"], name: "bookmarks_bookmarker_idx", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "post_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "city_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "doctor_albums", force: :cascade do |t|
    t.integer  "doctor_id",  limit: 4
    t.integer  "album_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "doctor_albums", ["album_id"], name: "index_doctor_albums_on_album_id", using: :btree
  add_index "doctor_albums", ["doctor_id"], name: "index_doctor_albums_on_doctor_id", using: :btree

  create_table "doctors", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.text     "specialty",               limit: 65535
    t.text     "experience",              limit: 65535
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "doctor_img_file_name",    limit: 255
    t.string   "doctor_img_content_type", limit: 255
    t.integer  "doctor_img_file_size",    limit: 4
    t.datetime "doctor_img_updated_at"
    t.integer  "hospital_id",             limit: 4
    t.integer  "gender",                  limit: 1,     default: 0, null: false
    t.integer  "city_id",                 limit: 4
    t.integer  "district_id",             limit: 4
    t.integer  "post_count",              limit: 4,     default: 0
    t.integer  "impressions_count",       limit: 4
    t.string   "slug",                    limit: 255
    t.integer  "status",                  limit: 4,     default: 0
  end

  add_index "doctors", ["slug"], name: "index_doctors_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, length: {"slug"=>70, "sluggable_type"=>nil, "scope"=>70}, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", length: {"slug"=>140, "sluggable_type"=>nil}, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "hospitals", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "city_id",     limit: 4
    t.integer  "district_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type", limit: 255
    t.integer  "impressionable_id",   limit: 4
    t.integer  "user_id",             limit: 4
    t.string   "controller_name",     limit: 255
    t.string   "action_name",         limit: 255
    t.string   "view_name",           limit: 255
    t.string   "request_hash",        limit: 255
    t.string   "ip_address",          limit: 255
    t.string   "session_hash",        limit: 255
    t.text     "message",             limit: 65535
    t.text     "referrer",            limit: 65535
    t.text     "params",              limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index", length: {"impressionable_type"=>nil, "impressionable_id"=>nil, "params"=>255}, using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: {"impressionable_type"=>nil, "message"=>255, "impressionable_id"=>nil}, using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "issues", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "phase_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "phasecates", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "phases", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "phasecate_id", limit: 4
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.text     "description",   limit: 65535
    t.integer  "doctor_id",     limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "subject",       limit: 4
    t.integer  "period",        limit: 4
    t.integer  "kind",          limit: 4
    t.integer  "comment_count", limit: 4,     default: 0
    t.integer  "phase_id",      limit: 4
    t.integer  "issue_id",      limit: 4
    t.integer  "user_id",       limit: 4,                 null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "profile_albums", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "profile_id", limit: 4
    t.integer  "album_id",   limit: 4
  end

  add_index "profile_albums", ["album_id"], name: "fk_rails_60c19a63ff", using: :btree
  add_index "profile_albums", ["profile_id"], name: "fk_rails_1cb35e0476", using: :btree

  create_table "profiles", id: false, force: :cascade do |t|
    t.integer  "user_id",                  limit: 4
    t.string   "location",                 limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "profile_img_file_name",    limit: 255
    t.string   "profile_img_content_type", limit: 255
    t.integer  "profile_img_file_size",    limit: 4
    t.datetime "profile_img_updated_at"
    t.integer  "number_of_baby",           limit: 4,     default: 0
    t.string   "nickname_of_baby",         limit: 255
    t.integer  "gender_of_baby",           limit: 4,     default: 0
    t.datetime "birthday_of_baby"
    t.text     "setting",                  limit: 65535
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "nickname",               limit: 255
    t.integer  "status",                 limit: 4,   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id",   limit: 4
    t.string   "votable_type", limit: 255
    t.integer  "voter_id",     limit: 4
    t.string   "voter_type",   limit: 255
    t.boolean  "vote_flag"
    t.string   "vote_scope",   limit: 255
    t.integer  "vote_weight",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "doctor_albums", "albums"
  add_foreign_key "doctor_albums", "doctors"
  add_foreign_key "profile_albums", "albums"
  add_foreign_key "profile_albums", "profiles", primary_key: "user_id"
  add_foreign_key "profiles", "users"
end
