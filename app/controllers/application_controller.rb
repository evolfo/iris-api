include ActionController::HttpAuthentication::Basic::ControllerMethods
include ActionController::HttpAuthentication::Token::ControllerMethods

class ApplicationController < ActionController::API
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "test"
    end
end
