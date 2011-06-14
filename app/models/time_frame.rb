class TimeFrame < ActiveRecord::Base

  has_and_belongs_to_many :games

  # CLASS METHODS

  def self.find_by_input(input)
    # whole lotta parsing and arcane magic goes here
    # instance of time/span/approximation comes in,
    # actual time comes out
    
    time = parse_text_into_time(input)
    return nil if time.nil? # if we don't get the date, let's bail
    time = time.change(:year => Date.today.year) if time.year.zero?
    expectation = find(:first, :conditions => [ "lower(expectation) LIKE ?", "%#{input.downcase}%" ])
    if expectation.present?
      [time, expectation]
    else

      now = Time.now
      if time.beginning_of_day == time
        time = time.to_date
        now = now.to_date
      end

      now_day = now.day
      now_month = now.month
      now_year = now.year

      now_hour = begin now.hour rescue 0 end
      now_minutes = begin now.min rescue 0 end

      day = time.day
      month = time.month
      year = time.year

      hour = begin time.hour rescue 0 end
      minutes = begin time.min rescue 0 end

      # full possibilities hash =>
      #   {:expect_day => , :expect_month => , :expect_year => ,
      #     :expect_hours => , :expect_minutes => ,
      #     :expect_in_days => , :expect_in_months => , :expect_in_years => ,
      #     :expect_in_hours => , :expect_in_minutes =>
      #   }
      possibilities = []
      possibilities << {:expect_day => day, :expect_month => month, :expect_year => year, :expect_hours => hour, :expect_minutes => minutes}
      possibilities << {:expect_day => day, :expect_month => month, :expect_year => year}
      possibilities << {:expect_day => day, :expect_month => month}
      possibilities << {:expect_month => month, :expect_year => year}
      possibilities << {:expect_month => month}
      possibilities << {:expect_hours => hour, :expect_minutes => minutes}
      possibilities << {:expect_hours => hour}


      # That pretty much covers the future dates
      difference = (time - now).round

      if time.instance_of?(DateTime)
        diff_hour = hour-now_hour
        diff_min = minutes-now_minutes
        if diff_hour > 0
          possibilities << ["expect_in_hours > ? AND expect_in_hours < ?", diff_hour-1, diff_hour+1]
          if diff_min > 0
            possibilities << ["expect_in_hours > ? AND expect_in_hours < ? AND expect_in_minutes > ? AND expect_in_minutes < ?", diff_hour-1, diff_hour+1, diff_min-10, diff_min+10]
            possibilities << ["expect_in_minutes > ? AND expect_in_minutes < ?", diff_min-10, diff_min+10]
          end
        end
      end

      days_diff = (time.to_date - now.to_date).to_i
      if days_diff > 0
        possibilities << ["expect_in_days > ? AND expect_in_days < ?", days_diff-7, days_diff+7]
        months_diff = (days_diff/30.4375).round
        if months_diff > 1
          possibilities << ["expect_in_months > ? AND expect_in_months < ?", months_diff-1, months_diff+1]
          possibilities << {:expect_in_years => months_diff/12} if months_diff/12 > 0
        end
      end

      #What to do with past dates?

      possible_expectations = []
      
      
      possibilities.each do |possibility|
        begin
          found_possibility = find(:first, :conditions => possibility)
          possible_expectations << found_possibility if found_possibility.present?
        rescue
        end
      end
      [time, possible_expectations.uniq]
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
