class CreateTimeFrames < ActiveRecord::Migration
  def self.up
    create_table :time_frames do |t|
      t.string :name
      t.string :expectation

      t.integer :expect_day
      t.integer :expect_month
      t.integer :expect_year
      t.integer :expect_hours
      t.integer :expect_minutes

      t.integer :expect_in_days
      t.integer :expect_in_months
      t.integer :expect_in_years
      t.integer :expect_in_hours
      t.integer :expect_in_minutes

      t.integer :advance_by_day
      t.integer :advance_by_month
      t.integer :advance_by_year
      t.integer :advance_by_hours
      t.integer :advance_by_minutes

      t.string :actual_release

      t.text :explanation
      t.string :source_url
      t.string :source

      t.timestamps
    end
    add_index :time_frames, :expectation
    add_index :time_frames, :expect_day
    add_index :time_frames, :expect_month
    add_index :time_frames, :expect_year
    add_index :time_frames, :expect_hours
    add_index :time_frames, :expect_minutes

  end

  def self.down
    drop_table :time_frames
  end
end
