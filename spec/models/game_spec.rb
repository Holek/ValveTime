require 'spec_helper'

describe Game do

  include GameSpecHelper

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

    it "has a time frame" do
      @game.should respond_to(:time_frame=)
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
