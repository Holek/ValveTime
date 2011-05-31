class TimeFrame < ActiveRecord::Base

  validates_presence_of :actual_date_string
  has_many :games

  def actual_date
#    if actual_date_string.present?
      chronic = Chronic.parse(actual_date_string)
      kronic = Kronic.parse(actual_date_string)
      if chronic.present?
        chronic
      elsif kronic.present?
        kronic
      else
        actual_date_string
      end
#    end
  end

  # CLASS METHODS

  def self.find_by_input(input)
    # whole lotta parsing and arcane magic goes here
    # instance of time/span/approximation comes in,
    # actual time comes out
    expectation = find(:first, :conditions => [ "lower(expectation) LIKE ?", "%#{input.downcase}%" ])
    if expectation.present?
      expectation
    else
      date = Chronic.parse(input)
      #NOT READY
    end
  end

  def self.find_or_initialize_from_giantbomb_record(giantbomb_record)
#"original_release_date"=>"1991-07-01 00:00:00", "expected_release_month"=>nil, "site_detail_url"=>"http://www.giantbomb.com/duke-nukem/61-8191/", "expected_release_quarter"=>nil, "expected_release_year"=>nil,
    if giantbomb_record["original_release_date"].present?
      self.find_by_input(giantbomb_record["original_release_date"])
    else
      date = ""
      date << Date::MONTHNAMES[giantbomb_record["expected_release_month"]] << " " if giantbomb_record["expected_release_month"].present?
      date << "Q" << giantbomb_record["expected_release_quarter"] << " " if giantbomb_record["expected_release_quarter"].present?
      date << giantbomb_record["expected_release_year"]
      self.find_by_input(date)
    end
  end
end
