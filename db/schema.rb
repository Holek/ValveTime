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

ActiveRecord::Schema.define(:version => 20110529220359) do

  create_table "games", :force => true do |t|
    t.string   "name"
    t.integer  "time_frame_id"
    t.string   "source_url"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["name"], :name => "index_games_on_name"
  add_index "games", ["time_frame_id"], :name => "index_games_on_time_frame_id"

  create_table "time_frames", :force => true do |t|
    t.string   "name"
    t.string   "expectation"
    t.string   "expectation_date_string_start"
    t.string   "expectation_date_string_end"
    t.datetime "expectation_date_precise_start"
    t.datetime "expectation_date_precise_end"
    t.string   "actual_date_string"
    t.text     "explanation"
    t.string   "source_url"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "time_frames", ["expectation"], :name => "index_time_frames_on_expectation"
  add_index "time_frames", ["expectation_date_precise_start", "expectation_date_precise_end"], :name => "index_time_frames_on_expectation_date_timestamp"
  add_index "time_frames", ["expectation_date_string_start", "expectation_date_string_end"], :name => "index_time_frames_on_expectation_date_string"

end
