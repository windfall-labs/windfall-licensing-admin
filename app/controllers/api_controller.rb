class ApiController < ActionController::Base
  include Authenticator
  include MetadataBuilder
  include CommonAction
  include CommonResponse

  # protect_from_forgery with: :null_session
  before_action :authenticate_request


  class NotAuthenticatedError < StandardError; end
  rescue_from NotAuthenticatedError do
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end

  class AuthenticationTimeoutError < StandardError; end
  rescue_from AuthenticationTimeoutError do
    render json: { error: 'Auth token is expired' }, status: 419 # unofficial timeout status code
  end


end
