class Game < ActiveRecord::Base

  has_and_belongs_to_many :time_frames

  validates_presence_of :name#, :time_frame

  def self.find_by_input(input)
    game = find_by_name(input)
    if game.nil?
      game_record = ValveTimeHelper.giantbomb_search_for(input).first
      game = game_record.to_game unless game_record.nil?
    end
    unless game.nil?
      {:game => game, :time_frames => game.time_frames}
    else
      nil
    end
  end

  def self.to_game(giantbomb_record)
    game = Game.new
    game.name = giantbomb_record["name"]
    game.source = "Giantbomb"
    game.source_url = giantbomb_record["site_detail_url"]
    time_frame = TimeFrame.find_or_initialize_from_giantbomb_record(giantbomb_record).second
    game.time_frames << time_frame unless time_frame.nil?
    game
  end
end
