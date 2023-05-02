class HealthCheckController < ApplicationController
  def index
    render status: 200
  end
end
