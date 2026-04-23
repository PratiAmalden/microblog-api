class ApplicationController < ActionController::API
  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound do
    render json: { errors: [ { message: "Not found" } ] }, status: :not_found
  end

  rescue_from ActionController::ParameterMissing do |e|
    render json: { errors: [ { message: "Required parameter is missing or invalid: #{e.param}" } ] }, status: :bad_request
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
