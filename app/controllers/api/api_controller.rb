module Api
  class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token, if: :json_request?

    skip_before_filter :authenticate_user!

    acts_as_token_authentication_handler_for User, fallback_to_devise: false
    before_action :require_authentication!

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def json_request?
      request.format.json?
    end

    def require_authentication!
      throw(:warden, scope: :user) unless current_user.presence
    end

    def failure
      render :json => {:success => false, :errors => ["Login Failed"]}, status: 401
    end

    def respond_with_failure(errors, status: :unprocessable_entity)
      render json: {errors: errors, messages: errors.full_messages}, status: status
    end

    def record_not_found(exception)
      render json: {errors: exception.message}, status: :not_found
    end

    def record_not_unique(*)
      render json: {errors: 'ID Already Exists'}, status: :unprocessable_entity
    end

    def user_not_authorized
      render json: {errors: 'Unauthorized'}, status: :unauthorized
    end
  end
end
