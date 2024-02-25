class AlphanumericUtility

  def self.letter_to_number value
    value.downcase.ord - 96
  end

  def self.number_to_letter value
    (value + 96).chr.upcase
  end

end
