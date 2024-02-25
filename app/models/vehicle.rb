class Vehicle
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :parking_transactions

  field :vehicle_type
  field :plate_number

  TYPES = ['small', 'medium', 'large']

  TYPES.each do |type|
    define_method "#{type}?" do
      vehicle_type == type
    end
  end



  scope :plate_number_is, -> (plate_number) do
    where(plate_number: /.*#{plate_number.downcase}.*/)
  end



  def latest_parking_transaction
    self.parking_transactions.order_by(:start_time => :desc).first
  end

  def latest_completed_parking_transaction
    self.parking_transactions.completed.order_by(:start_time => :desc).first
  end

end
