class RelationshipsController < ApplicationController
  include UserSessionizeService

  def create
    session_user.follow(params[:user_id])
    render status: 201
  end

  def destroy
    session_user.unfollow(params[:user_id])
    render status: 204
  end

end
