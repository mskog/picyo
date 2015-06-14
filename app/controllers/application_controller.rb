class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, if: :json_request?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def json_request?
    request.format.json?
  end

  def record_not_found
    render plain: "404 Not Found", status: 404
  end
end
