class ApplicationController < ActionController::API
  include ActionController::Cookies
  include UserAuthenticateService
end
