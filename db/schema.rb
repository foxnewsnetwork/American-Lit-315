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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120112165030) do

  create_table "ad_stats", :force => true do |t|
    t.integer  "ad_id"
    t.integer  "user_id"
    t.integer  "views"
    t.integer  "clicks"
    t.integer  "closes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ad_stats", ["ad_id", "user_id"], :name => "index_ad_stats_on_ad_id_and_user_id", :unique => true
  add_index "ad_stats", ["ad_id"], :name => "index_ad_stats_on_ad_id"
  add_index "ad_stats", ["user_id"], :name => "index_ad_stats_on_user_id"

  create_table "ads", :force => true do |t|
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ads", ["company_id"], :name => "index_ads_on_company_id"

  create_table "companies", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["email"], :name => "index_companies_on_email", :unique => true
  add_index "companies", ["name"], :name => "index_companies_on_name", :unique => true
  add_index "companies", ["reset_password_token"], :name => "index_companies_on_reset_password_token", :unique => true

  create_table "coupon_stats", :force => true do |t|
    t.integer  "coupon_id"
    t.integer  "user_id"
    t.integer  "interactions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coupon_stats", ["coupon_id", "user_id"], :name => "index_coupon_stats_on_coupon_id_and_user_id", :unique => true
  add_index "coupon_stats", ["coupon_id"], :name => "index_coupon_stats_on_coupon_id"
  add_index "coupon_stats", ["user_id"], :name => "index_coupon_stats_on_user_id"

  create_table "coupons", :force => true do |t|
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coupons", ["company_id"], :name => "index_coupons_on_company_id"

  create_table "game_stats", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.integer  "plays"
    t.decimal  "duration_average", :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_stats", ["game_id", "user_id"], :name => "index_game_stats_on_game_id_and_user_id", :unique => true
  add_index "game_stats", ["game_id"], :name => "index_game_stats_on_game_id"
  add_index "game_stats", ["user_id"], :name => "index_game_stats_on_user_id"

  create_table "games", :force => true do |t|
    t.integer  "publisher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["publisher_id"], :name => "index_games_on_publisher_id"

  create_table "products", :force => true do |t|
    t.integer  "company_id"
    t.integer  "ext_product_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publishers", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publishers", ["email"], :name => "index_publishers_on_email", :unique => true
  add_index "publishers", ["name"], :name => "index_publishers_on_name", :unique => true
  add_index "publishers", ["reset_password_token"], :name => "index_publishers_on_reset_password_token", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
