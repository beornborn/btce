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

ActiveRecord::Schema.define(version: 20140203170948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "day3s", force: true do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "day3s", ["time"], name: "index_day3s_on_time", using: :btree

  create_table "day7s", force: true do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "day7s", ["time"], name: "index_day7s_on_time", using: :btree

  create_table "days", force: true do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "days", ["time"], name: "index_days_on_time", using: :btree

  create_table "exchanges", force: true do |t|
    t.string "name"
    t.text   "options"
  end

  create_table "hour12s", force: true do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "hour12s", ["time"], name: "index_hour12s_on_time", using: :btree

  create_table "hour2s", force: true do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "hour2s", ["time"], name: "index_hour2s_on_time", using: :btree

  create_table "hour4s", force: true do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "hour4s", ["time"], name: "index_hour4s_on_time", using: :btree

  create_table "hour6s", force: true do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "hour6s", ["time"], name: "index_hour6s_on_time", using: :btree

  create_table "hours", force: true do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "hours", ["time"], name: "index_hours_on_time", using: :btree

  create_table "ichimokus", force: true do |t|
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

  create_table "indicator_values", force: true do |t|
    t.datetime "time"
    t.decimal  "tenkan_sen",    precision: 24, scale: 12
    t.decimal  "kijun_sen",     precision: 24, scale: 12
    t.decimal  "chinkou_span",  precision: 24, scale: 12
    t.decimal  "senkou_span_a", precision: 24, scale: 12
    t.decimal  "senkou_span_b", precision: 24, scale: 12
  end

  add_index "indicator_values", ["time"], name: "index_indicator_values_on_time", using: :btree

  create_table "indicators", force: true do |t|
    t.string "name"
    t.text   "options"
  end

  create_table "minute15s", force: true do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "minute15s", ["time"], name: "index_minute15s_on_time", using: :btree

  create_table "minute30s", force: true do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "minute30s", ["time"], name: "index_minute30s_on_time", using: :btree

  create_table "minute3s", force: true do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "minute3s", ["time"], name: "index_minute3s_on_time", using: :btree

  create_table "minute5s", force: true do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "minute5s", ["time"], name: "index_minute5s_on_time", using: :btree

  create_table "minutes", force: true do |t|
    t.datetime "time"
    t.decimal  "open",     precision: 24, scale: 12
    t.decimal  "high",     precision: 24, scale: 12
    t.decimal  "low",      precision: 24, scale: 12
    t.decimal  "close",    precision: 24, scale: 12
    t.decimal  "amount",   precision: 24, scale: 12
    t.decimal  "tramount", precision: 24, scale: 12
  end

  add_index "minutes", ["time"], name: "index_btce_minutes_on_time", using: :btree

  create_table "points", force: true do |t|
    t.datetime "time"
    t.text     "val"
  end

  add_index "points", ["time"], name: "index_points_on_time", using: :btree

  create_table "strategies", force: true do |t|
    t.string "name"
    t.text   "options"
    t.string "options_hash"
  end

  create_table "system_data", force: true do |t|
    t.string "name"
    t.text   "val"
  end

  create_table "trade_results", force: true do |t|
    t.datetime "time"
    t.decimal  "usd",          precision: 24, scale: 12
    t.decimal  "estimate_usd", precision: 24, scale: 12
    t.decimal  "btc",          precision: 24, scale: 12
    t.string   "action"
    t.integer  "trade_id"
  end

  add_index "trade_results", ["time"], name: "index_trade_results_on_time", using: :btree

  create_table "trades", force: true do |t|
    t.datetime "begin"
    t.datetime "end"
    t.decimal  "initial_usd",  precision: 24, scale: 12
    t.decimal  "usd",          precision: 24, scale: 12
    t.decimal  "estimate_usd", precision: 24, scale: 12
    t.decimal  "btc",          precision: 24, scale: 12
    t.integer  "exchange_id"
    t.integer  "strategy_id"
    t.decimal  "profit_rate",  precision: 4,  scale: 2
    t.text     "options"
  end

  create_table "transactions", force: true do |t|
    t.datetime "time"
    t.decimal  "price",  precision: 24, scale: 12
    t.decimal  "amount", precision: 24, scale: 12
  end

  add_index "transactions", ["time"], name: "index_transactions_on_time", using: :btree

end
