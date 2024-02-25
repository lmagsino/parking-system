class ApplicationService

  def self.call *args, &block
    new(*args, &block).call
  end

  def handle_error message
    Rails.logger.error message
    nil
  end

end
