module ConvertHelper

  # This method will advance the expected time of release to the one after delays
  def actual_release_date(time, expectations)
    if expectations.any?(&:actual_release)
      expectations.each do |tf|
        return tf.actual_release if tf.actual_release?
      end
    end
    advance_words = %w(day month year)
    if time.instance_of?(DateTime) || time.instance_of?(Time)
      advance_words << %w(hours minutes)
      advance_words.flatten!
    end
    advance_by = {}
    advance_words.each do |word|
      advance_by[:"#{word.pluralize}"] = begin
        expectations.sum(&:"advance_by_#{word}")
      rescue
        sum = 0
        expectations.each do |expectation|
          sum += expectation.send(:"advance_by_#{word}").to_i
        end
        sum
      end
    end
    time.advance(advance_by).to_s(:long)
  end
end
