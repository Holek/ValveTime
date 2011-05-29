class ApplicationController < ActionController::Base
  def giantbomb_search_for(name)
    begin
      search = GiantBomb::Search.new
      search.limit(10)
      search.resources("game")
      search.fields("name,image,expected_release_month,expected_release_quarter,expected_release_year,original_release_date")
      search.query(name)
      search.fetch
      #expected to return:
      #[{"name":"DOTA 2","original_release_date":null,"resource_type":"game","expected_release_month":null,"expected_release_quarter":4,"expected_release_year":2011,"image":{"super_url":"http://media.giantbomb.com/uploads/0/8123/1555513-logo610_super.jpg","icon_url":"http://media.giantbomb.com/uploads/0/8123/1555513-logo610_icon.jpg","small_url":"http://media.giantbomb.com/uploads/0/8123/1555513-logo610_small.jpg","thumb_url":"http://media.giantbomb.com/uploads/0/8123/1555513-logo610_thumb.jpg","tiny_url":"http://media.giantbomb.com/uploads/0/8123/1555513-logo610_tiny.jpg","medium_url":"http://media.giantbomb.com/uploads/0/8123/1555513-logo610_small.jpg","screen_url":"http://media.giantbomb.com/uploads/0/8123/1555513-logo610_screen.jpg"}}]
    rescue
      []
    end
  end
end
