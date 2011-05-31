class CreateTimeFrames < ActiveRecord::Migration
  def self.up
    create_table :time_frames do |t|
      t.string :name
      t.string :expectation
      t.string :expectation_date_string_start
      t.string :expectation_date_string_end
      t.timestamp :expectation_date_precise_start
      t.timestamp :expectation_date_precise_end
      t.string :actual_date_string
      t.text :explanation
      t.string :source_url
      t.string :source

      t.timestamps
    end
    add_index :time_frames, :expectation
    #add_index :time_frames, :actual_date_string
    add_index :time_frames, [:expectation_date_precise_start, :expectation_date_precise_end], :name => :index_time_frames_on_expectation_date_timestamp
    add_index :time_frames, [:expectation_date_string_start, :expectation_date_string_end], :name => :index_time_frames_on_expectation_date_string
  end

  def self.down
    drop_table :time_frames
  end
end
