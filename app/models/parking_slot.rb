class ParkingSlot
  include Mongoid::Document
  include Mongoid::Timestamps


  belongs_to :parking_lot

  field :parking_type
  field :location

  TYPES = ['small', 'medium', 'large']

  TYPES.each do |type|
    define_method "#{type}?" do
      parking_type == type
    end
  end



  state_machine :status, :initial => :available do
    event :occupy do
      transition :available => :occupied
    end

    event :release do
      transition :occupied => :available
    end
  end



  scope :under, -> (parking_lot)do
    where :parking_lot => parking_lot
  end

  scope :parking_type_in, -> (parking_types)do
    where :parking_type.in => parking_types
  end

  scope :available, -> do
    where :status => :available
  end

  scope :ordered_by_created_at, -> do
    order :created_at => :desc
  end

end
