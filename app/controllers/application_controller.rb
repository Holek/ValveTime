class ApplicationController < ActionController::Base

  helper_method :giantbomb_search_for

  def giantbomb_search_for(name)
    begin
      search = GiantBomb::Search.new
      search.limit(10)
      search.resources("game")
      search.fields("name,image,expected_release_month,expected_release_quarter,expected_release_year,original_release_date,site_detail_url")
      search.query(name)
      search.fetch
    rescue
      []
    end
  end
end
