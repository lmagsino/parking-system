class ParkingTransaction
  include Mongoid::Document
  include Mongoid::Timestamps

  include ::Callbacks::ParkingTransaction

  belongs_to :parking_slot
  belongs_to :vehicle

  field :start_time, type:DateTime
  field :end_time, type:DateTime
  field :returning, type: Boolean
  field :amount, type: BigDecimal



  state_machine :status, :initial => :pending do
    event :start do
      transition :pending => :started
    end

    event :complete do
      transition :started => :completed
    end

    before_transition :on => :complete, :do => :compute_amount
    before_transition :on => :start, :do => :occupy_parking_slot
    before_transition :on => :complete, :do => :release_parking_slot
  end



  scope :completed, -> do
    where :status => :completed
  end

  scope :ordered_by_created_at, -> do
    order :created_at => :desc
  end

end
