class ParkingTransaction
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :parking_slot
  belongs_to :vehicle

  field :start_time
  field :end_time
  field :returning



  state_machine :status, :initial => :pending do
    event :start do
      transition :pending => :started
    end

    event :complete do
      transition :started => :completed
    end

    before_transition :on => :complete, :do => :compute_amount
    after_transition :on => :start, :do => :occupy_parking_slot
    after_transition :on => :complete, :do => :release_parking_slot
  end



  scope :completed, -> do
    where :status => :completed
  end

  scope :ordered_by_created_at, -> do
    order :created_at => :desc
  end

end
