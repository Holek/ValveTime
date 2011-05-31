class Game < ActiveRecord::Base

  belongs_to :time_frame

  validates_presence_of :name, :time_frame

  def self.find_by_input(input)
    begin
      game = find_by_name(input)
    rescue
      game = Game.to_game(giantbomb_search_for(input).first)
    end
    {:game => game, :timeframe => game.time_frame}
  end
  
  def self.to_game(giantbomb_record)
    game = Game.new
    game.title = giantbomb_record["name"]
    game.source = "Giantbomb"
    game.source_url = giantbomb_record["site_detail_url"]
    game.time_frame = TimeFrame.find_or_initialize_from_giantbomb_record(giantbomb_record)
    game
  end
end
