class DatetimeUtility

  def self.valid_datetime? value
    Time.parse value
    true
  rescue ArgumentError
    false
  end

end
