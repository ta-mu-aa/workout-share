class ApplicationController < ActionController::API
  include ActionController::Cookies
  include UserAuthenticateService
  include UserSessionizeService

  private
  
    def response_500(msg = "Internal Server Error")
      render status: 500, json: { status: 500, error: msg }
    end

end