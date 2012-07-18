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

ActiveRecord::Schema.define(:version => 20120718184024) do

  create_table "bark_parses", :force => true do |t|
    t.integer  "bark_id"
    t.text     "x_choice"
    t.string   "x_hyper0"
    t.string   "x_hyper1"
    t.text     "x_hyper2plus"
    t.string   "x_loc_hyper0"
    t.string   "x_loc_hyper1"
    t.text     "x_loc_hyper2plus"
    t.text     "x_clause"
    t.text     "x_pp"
    t.text     "y_category"
    t.string   "y_hyper0"
    t.string   "y_hyper1"
    t.text     "y_hyper2plus"
    t.string   "y_loc_hyper0"
    t.string   "y_loc_hyper1"
    t.text     "y_loc_hyper2plus"
    t.text     "y_clause"
    t.text     "y_pp"
    t.text     "z_reason"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
