require 'spec_helper'

describe Game do

  let(:giantbomb_record) do
    {"name"=>"Duke Nukem", "resource_type"=>"game", "original_release_date"=>"1991-07-01 00:00:00", "expected_release_month"=>nil, "site_detail_url"=>"http://www.giantbomb.com/duke-nukem/61-8191/", "expected_release_quarter"=>nil, "expected_release_year"=>nil, "image"=>{"super_url"=>"http://media.giantbomb.com/uploads/0/3564/261211-title_em_super.jpg", "icon_url"=>"http://media.giantbomb.com/uploads/0/3564/261211-title_em_icon.jpg", "small_url"=>"http://media.giantbomb.com/uploads/0/3564/261211-title_em_small.jpg", "thumb_url"=>"http://media.giantbomb.com/uploads/0/3564/261211-title_em_thumb.jpg", "tiny_url"=>"http://media.giantbomb.com/uploads/0/3564/261211-title_em_tiny.jpg", "medium_url"=>"http://media.giantbomb.com/uploads/0/3564/261211-title_em_small.jpg", "screen_url"=>"http://media.giantbomb.com/uploads/0/3564/261211-title_em_screen.jpg"}}
  end

  context 'class methods' do
    it 'can find a game by input' do
      Game.should respond_to(:find_by_input)
    end
  end

  context "attributes" do
    before :all do
      @game = Game.new
    end

    it "has a name" do
      @game.should respond_to(:name=)
    end

    it "has time frames" do
      @game.should respond_to(:time_frames=)
    end

    it "has a source" do
      @game.should respond_to(:source=)
    end

    it "has a source URL" do
      @game.should respond_to(:source_url=)
    end
  end

  context "class methods" do
    it "finds a game from input" do
      Game.should respond_to(:find_by_input)
    end

    it 'gives a Game instance from a giantbomb record' do
      game = Game.to_game(giantbomb_record)
      game.should be_an_instance_of(Game)
      game.should be_valid
    end

    it 'gives a Game instance from a giantbomb record (via Hash)' do
      game = giantbomb_record.to_game
      game.should be_an_instance_of(Game)
      game.should be_valid
    end
  end
end
