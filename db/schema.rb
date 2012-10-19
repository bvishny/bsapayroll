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

ActiveRecord::Schema.define(:version => 20121019071316) do

  create_table "cc_batches", :force => true do |t|
    t.date     "batch_date"
    t.string   "batch_number"
    t.string   "customer_code"
    t.integer  "user_id"
    t.string   "gl_account_number"
    t.float    "vs_total",          :default => 0.0
    t.float    "mc_total",          :default => 0.0
    t.float    "dis_total",         :default => 0.0
    t.float    "amex_total",        :default => 0.0
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "cc_batches", ["batch_number"], :name => "index_cc_batches_on_batch_number"
  add_index "cc_batches", ["user_id"], :name => "index_cc_batches_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "auth_key"
    t.string   "employee_id"
    t.string   "position_id"
    t.string   "password_digest"
    t.float    "hourly_rate",        :default => 11.0
    t.string   "work_unit",          :default => "MANAGEMENT"
    t.boolean  "is_admin",           :default => false
    t.boolean  "active",             :default => true
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.boolean  "report_payroll"
    t.boolean  "can_submit_batches", :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"

  create_table "weeks", :force => true do |t|
    t.integer  "user_id"
    t.date     "begins"
    t.date     "ends"
    t.float    "day_0",       :default => 0.0
    t.float    "day_1",       :default => 0.0
    t.float    "day_2",       :default => 0.0
    t.float    "day_3",       :default => 0.0
    t.float    "day_4",       :default => 0.0
    t.float    "day_5",       :default => 0.0
    t.float    "day_6",       :default => 0.0
    t.float    "hourly_rate", :default => 11.0
    t.boolean  "approved",    :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "comments"
  end

  add_index "weeks", ["begins"], :name => "index_weeks_on_begins"
  add_index "weeks", ["ends"], :name => "index_weeks_on_ends"
  add_index "weeks", ["user_id"], :name => "index_weeks_on_user_id"

end
