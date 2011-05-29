class ConvertController < ApplicationController

  def index
    if params[:name]
      @input = params[:name]
      date_check = Chronic.parse(@input)
      if date_check.present?
        @type = "date"
        @output = date_check.to_time
      else
        @type = "game"
        @output = giantbomb_search_for(@input).first
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
