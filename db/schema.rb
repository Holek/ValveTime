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

ActiveRecord::Schema.define(:version => 20110529224857) do

  create_table "games", :force => true do |t|
    t.string   "name"
    t.string   "source_url"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["name"], :name => "index_games_on_name"

  create_table "games_time_frames", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "time_frame_id"
  end

  create_table "time_frames", :force => true do |t|
    t.string   "name"
    t.string   "expectation"
    t.integer  "expect_day"
    t.integer  "expect_month"
    t.integer  "expect_year"
    t.integer  "expect_hours"
    t.integer  "expect_minutes"
    t.integer  "expect_in_days"
    t.integer  "expect_in_months"
    t.integer  "expect_in_years"
    t.integer  "expect_in_hours"
    t.integer  "expect_in_minutes"
    t.integer  "advance_by_day"
    t.integer  "advance_by_month"
    t.integer  "advance_by_year"
    t.integer  "advance_by_hours"
    t.integer  "advance_by_minutes"
    t.string   "actual_release"
    t.text     "explanation"
    t.string   "source_url"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "time_frames", ["expect_day"], :name => "index_time_frames_on_expect_day"
  add_index "time_frames", ["expect_hours"], :name => "index_time_frames_on_expect_hours"
  add_index "time_frames", ["expect_minutes"], :name => "index_time_frames_on_expect_minutes"
  add_index "time_frames", ["expect_month"], :name => "index_time_frames_on_expect_month"
  add_index "time_frames", ["expect_year"], :name => "index_time_frames_on_expect_year"
  add_index "time_frames", ["expectation"], :name => "index_time_frames_on_expectation"

end
