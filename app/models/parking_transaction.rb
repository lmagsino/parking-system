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

  STATUS_PENDING = :pending
  STATUS_STARTED = :started
  STATUS_COMPLETED = :completed



  state_machine :status, :initial => STATUS_PENDING do
    event :start do
      transition STATUS_PENDING => STATUS_STARTED
    end

    event :complete do
      transition STATUS_STARTED => STATUS_COMPLETED
    end

    before_transition :on => :complete, :do => :compute_amount
    after_transition :on => :start, :do => :occupy_parking_slot
    after_transition :on => :complete, :do => :release_parking_slot
  end



  scope :completed, -> do
    where :status => STATUS_COMPLETED
  end

  scope :ordered_by_created_at, -> do
    order :created_at => :desc
  end

end
