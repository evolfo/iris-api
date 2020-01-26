class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods

    def authenticate
      authenticate_or_request_with_http_token do |username, password|
       username == "admin" && password == "test"
      end
    end
end
