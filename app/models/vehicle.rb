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



  scope :plate_number_is, -> (plate_number) do
    where 'lower(plate_number) = ?', plate_number.downcase
  end



  def latest_parking_transaction
    self.parking_transactions.order(:start_time).last
  end

  def latest_completed_parking_transaction
    self.parking_transactions.order(:start_time).completed.last
  end

end
