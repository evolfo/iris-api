class ApplicationController < ActionController::API
  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "test"
    end
  end
end
