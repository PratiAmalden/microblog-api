class ApplicationController < ActionController::API
  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?

  def route_not_found
    render json: {
      error: "Route not found",
      message: "No route matches #{params[:unmatched]}" 
    }, status: :not_found
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end

  private
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: "Not found", message: e.message }, status: :not_found
  end

  rescue_from ActionController::ParameterMissing do |e|
    render json: { error: "Required parameter missing: #{e.param}" }, status: :bad_request
  end
end
