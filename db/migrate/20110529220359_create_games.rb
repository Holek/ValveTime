class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :name
      t.integer :time_frame_id
      t.string :source_url
      t.string :source

      t.timestamps
    end
    add_index :games, :name
    add_index :games, :time_frame_id
  end

  def self.down
    drop_table :games
  end
end
