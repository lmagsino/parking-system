class Vehicle
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :parking_transactions

  field :type
  field :plate_number

  TYPES = {
    :small => 0,
    :medium => 1,
    :large => 2
  }.freeze


  def type= value
    super value
  end

  def type
    TYPES.key super
  end

  def small?
    type == :small
  end

  def medium?
    type == :medium
  end

  def large?
    type == :large
  end

end
