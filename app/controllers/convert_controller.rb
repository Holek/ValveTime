class ConvertController < ApplicationController

  def index
    @name = params[:name]
  end
  
  def autocomplete
    result = giantbomb_search_for(params[:name])
    respond_to { |wants|
      wants.json { render :text => result.to_json }
    }
  end

end
