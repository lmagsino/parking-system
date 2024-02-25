class ParkingSlot
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :parking_lot

  field :parking_type
  field :location

  TYPES = ['small', 'medium', 'large']

  validates :parking_lot, presence: true
  validates :parking_type, inclusion: { in: TYPES }
  validates :location, presence: true



  state_machine :status, :initial => :available do
    event :occupy do
      transition :available => :occupied
    end

    event :release do
      transition :occupied => :available
    end
  end



  TYPES.each do |type|
    define_method "#{type}?" do
      parking_type == type
    end
  end



  scope :under, -> (parking_lot) { where :parking_lot => parking_lot }
  scope :parking_type_in, -> (parking_types) { where(:parking_type.in => parking_types) }
  scope :available, -> { where :status => :available }
  scope :ordered_by_created_at, -> { order :created_at => :desc }

end
