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

ActiveRecord::Schema.define(version: 20140308180944) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "days", force: :cascade do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "days", ["time"], name: "index_days_on_time", using: :btree

  create_table "hour4s", force: :cascade do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "hour4s", ["time"], name: "index_hour4s_on_time", using: :btree

  create_table "hours", force: :cascade do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "hours", ["time"], name: "index_hours_on_time", using: :btree

  create_table "ichimokus", force: :cascade do |t|
    t.integer  "indicator_id"
    t.datetime "time"
    t.decimal  "tenkan_sen",    precision: 24, scale: 12
    t.decimal  "kijun_sen",     precision: 24, scale: 12
    t.decimal  "chinkou_span",  precision: 24, scale: 12
    t.decimal  "senkou_span_a", precision: 24, scale: 12
    t.decimal  "senkou_span_b", precision: 24, scale: 12
  end

  add_index "ichimokus", ["indicator_id"], name: "index_ichimokus_on_indicator_id", using: :btree
  add_index "ichimokus", ["time"], name: "index_ichimokus_on_time", using: :btree

  create_table "indicators", force: :cascade do |t|
    t.string "name"
    t.text   "options"
  end

  create_table "minute15s", force: :cascade do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "minute15s", ["time"], name: "index_minute15s_on_time", using: :btree

  create_table "minutes", force: :cascade do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "minutes", ["time"], name: "index_minutes_on_time", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "plan_id"
    t.integer  "user_id"
    t.integer  "btce_id"
    t.string   "pair"
    t.string   "type"
    t.decimal  "amount"
    t.decimal  "rate"
    t.datetime "timestamp_created"
    t.string   "status"
    t.decimal  "spent_usd"
    t.decimal  "sell_price"
    t.decimal  "buy_price"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.string   "pair"
    t.integer  "th"
    t.decimal  "depo"
    t.decimal  "min"
    t.decimal  "max"
    t.decimal  "pr"
    t.decimal  "martin"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "strategies", force: :cascade do |t|
    t.string "name"
    t.text   "options"
    t.string "options_hash"
  end

  create_table "system_data", force: :cascade do |t|
    t.string "name"
    t.text   "val"
  end

  create_table "trade_results", force: :cascade do |t|
    t.datetime "time"
    t.decimal  "usd",          precision: 24, scale: 12
    t.decimal  "estimate_usd", precision: 24, scale: 12
    t.decimal  "btc",          precision: 24, scale: 12
    t.decimal  "estimate_btc", precision: 24, scale: 12
    t.decimal  "price",        precision: 24, scale: 12
    t.string   "action"
    t.integer  "trade_id"
  end

  add_index "trade_results", ["time"], name: "index_trade_results_on_time", using: :btree

  create_table "trades", force: :cascade do |t|
    t.integer  "strategy_id"
    t.datetime "begin"
    t.datetime "end"
    t.decimal  "initial_usd",  precision: 24, scale: 12
    t.decimal  "usd",          precision: 24, scale: 12
    t.decimal  "btc",          precision: 24, scale: 12
    t.decimal  "estimate_usd", precision: 24, scale: 12
    t.decimal  "estimate_btc", precision: 24, scale: 12
    t.decimal  "profit_rate",  precision: 4,  scale: 2
    t.text     "options"
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "time"
    t.decimal  "price",  precision: 24, scale: 12
    t.decimal  "amount", precision: 24, scale: 12
  end

  add_index "transactions", ["time"], name: "index_transactions_on_time", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                           null: false
    t.string   "crypted_password",                null: false
    t.string   "salt",                            null: false
    t.string   "btce_key"
    t.string   "btce_secret"
    t.integer  "nonce",            default: 1
    t.boolean  "api_allowed",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
