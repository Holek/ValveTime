class ConvertController < ApplicationController

  def index
    if params[:name]
      @input = params[:name]
      time_frame_check = TimeFrame.find_by_input(@input)
      if time_frame_check.present?
        @type = "time_frame"
        @output = time_frame_check
      else
        @type = "game"
        @output = Game.find_by_input(@input)
      end
    end
    respond_to { |wants|
      wants.html
      wants.json { render :text => {:type => @type, :input => @input, :output => @output}.to_json }
    }
  end
  
  def autocomplete
    result = giantbomb_search_for(params[:name])
    respond_to { |wants|
      wants.json { render :text => result.to_json }
    }
  end

end
