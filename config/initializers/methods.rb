def parse_text_into_time(input)
  input.to_time if input.respond_to?(:to_time)
rescue ArgumentError
  chronic = Chronic.parse(input)
  kronic = Kronic.parse(input)
  if chronic.present?
    chronic
  elsif kronic.present?
    kronic
  else
    nil
  end
end

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
