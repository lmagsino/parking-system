class EntryPointsGenerator < ApplicationService

  def initialize entry_point
    @entry_point = entry_point
  end

  def call
    1.upto(@entry_point).map do |point|
      AlphanumericUtility.number_to_letter point
    end
  end

end
