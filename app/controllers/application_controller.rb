class ApplicationController < ActionController::Base

  protect_from_forgery :with => :exception
  skip_before_action :verify_authenticity_token

  rescue_from Mongoid::Errors::DocumentNotFound, with: :render_not_found



  def handle_error exception
    error_message = "Error: #{exception.message}"
    Rails.logger.error error_message
    render_json({ message: exception.message }, :bad_request)
  end

  def render_json data, status
    render :json => data, :status => status
  end

  def render_errors errors, status
    render json: { errors: errors }, status: status
  end

  def render_not_found
    render_json({ error: "Resource with ID #{params[:id]} not found" } , :not_found)
  end

end
