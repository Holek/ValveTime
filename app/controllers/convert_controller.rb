class ConvertController < ApplicationController

  def index
    if params[:input]
      @input = params[:input]
      time_frame_check = TimeFrame.find_by_input(@input)
      if time_frame_check.present?
        @type = "time_frame"
        @time = time_frame_check.first
        @output = time_frame_check.second
      else
        @type = "game"
        @output = Game.find_by_input(@input)
        #@time = @output.
      end
    end

    respond_to { |wants|
      wants.html
      wants.json { render :text => {:type => @type, :input => @input, :output => @output}.to_json }
      wants.txt { render :layout => false }
    }
  end
  
  def autocomplete
    # if a user typed in a date, we don't want to show any autocomplete stuff
    Date.parse(params[:input])
    respond_to { |wants|
      wants.json { render :text => [] }
    }
  rescue ArgumentError, TypeError
    result = giantbomb_search_for(params[:input])
    respond_to { |wants|
      wants.json { render :text => result.to_json }
    }
  end

end
