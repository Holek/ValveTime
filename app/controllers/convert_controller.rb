class ConvertController < ApplicationController

  def index
  end
  
  def autocomplete
    search = GiantBomb::Search.new
    search.limit(10)
    search.resources("game")
    search.fields("name,image,expected_release_month,expected_release_quarter,expected_release_year,original_release_date")
    search.query(params[:name])
    result = search.fetch
    respond_to { |wants|
      wants.json { render :text => result.to_json }
    }
  end

end
