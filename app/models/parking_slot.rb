class ParkingSlot
  include Mongoid::Document
  include Mongoid::Timestamps


  belongs_to :parking_lot

  field :parking_type

  PARKING_TYPES = {
    :small => 0,
    :medium => 1,
    :large => 2
  }.freeze


  def parking_type=(value)
    super(PARKING_TYPES.key(value))
  end

  def parking_type
    PARKING_TYPES[super.to_sym]
  end

  def small?
    parking_type == :small
  end

  def medium?
    parking_type == :medium
  end

  def large?
    parking_type == :large
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

  scope :with_parking_type, -> (parking_type)do
    where :parking_type => parking_type
  end

  scope :available, -> do
    where :status => :available
  end

  scope :ordered_by_created_at, -> do
    order :created_at => :desc
  end

end
