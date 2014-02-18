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

ActiveRecord::Schema.define(version: 20140217171808) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.integer  "country_id"
    t.integer  "old_id"
    t.integer  "league_id"
  end

  add_index "clubs", ["country_id"], name: "index_clubs_on_country_id", using: :btree
  add_index "clubs", ["league_id"], name: "index_clubs_on_league_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "country"
    t.string   "country_short"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", force: true do |t|
    t.string   "name"
    t.integer  "level"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  add_index "leagues", ["country_id"], name: "index_leagues_on_country_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "screen_name"
    t.string   "location"
    t.string   "locale",                 default: "en"
    t.string   "subscription",           default: "none"
    t.string   "role",                   default: "user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vinks", force: true do |t|
    t.integer  "vink_nr"
    t.datetime "vink_date"
    t.string   "ground"
    t.string   "street"
    t.string   "city"
    t.string   "result"
    t.string   "season"
    t.string   "kickoff"
    t.integer  "gate"
    t.decimal  "ticket"
    t.boolean  "countfor92"
    t.integer  "rating"
    t.integer  "club_id"
    t.integer  "away_club_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "league_id"
  end

  add_index "vinks", ["away_club_id"], name: "index_vinks_on_away_club_id", using: :btree
  add_index "vinks", ["club_id"], name: "index_vinks_on_club_id", using: :btree
  add_index "vinks", ["user_id"], name: "index_vinks_on_user_id", using: :btree

end
