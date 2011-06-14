class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :name
      t.string :source_url
      t.string :source

      t.timestamps
    end
    add_index :games, :name

    #join ctable for games and time frames
    create_table :games_time_frames, :id => false do |t|
      t.integer :game_id
      t.integer :time_frame_id
    end
  end

  def self.down
    drop_table :games
    drop_table :games_time_frames
  end
end
