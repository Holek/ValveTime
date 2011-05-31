# This piece of code makes Chronic aware of year quarters

class Chronic::Repeater < Chronic::Tag #:nodoc:

  def self.scan_for_season_names(token)
    scanner = {/^springs?$/ => :spring, /^q1$/ => :spring, /^quarter 1$/ => :spring,
               /^summers?$/ => :summer, /^q2$/ => :summer, /^quarter 1$/ => :summer,
               /^(autumn)|(fall)s?$/ => :autumn, /^q3$/ => :autumn, /^quarter 3$/ => :autumn,
               /^winters?$/ => :winter, /^q4$/ => :winter,  /^quarter 4$/ => :winter}
    scanner.keys.each do |scanner_item|
      return Chronic::RepeaterSeasonName.new(scanner[scanner_item]) if scanner_item =~ token.word
    end

    return nil
  end

end
