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

ActiveRecord::Schema.define(version: 2021_06_17_223852) do

  create_table "rails_server_monitor_server_snapshots", force: :cascade do |t|
    t.float "cpu_usage_percentage"
    t.float "ram_usage_percentage"
    t.float "hdd_usage_percentage"
    t.text "ram_stats"
    t.text "hdd_stats"
    t.text "network_stats"
    t.integer "rails_server_monitor_server_id", null: false
    t.datetime "created_at"
    t.index ["created_at"], name: "index_rails_server_monitor_server_snapshots_on_created_at"
    t.index ["rails_server_monitor_server_id"], name: "rails_server_monitor_snapshots_on_server"
  end

  create_table "rails_server_monitor_servers", force: :cascade do |t|
    t.string "hostname"
    t.datetime "last_seen_at"
    t.string "custom_name"
    t.text "custom_description"
    t.text "system_information"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "rails_server_monitor_server_snapshots", "rails_server_monitor_servers"
end
