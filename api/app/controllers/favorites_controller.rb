class FavoritesController < ApplicationController
  before_action :set_post
  before_action :sessionize_user

  def create
    Favorite.create(user_id: session_user.id,  post_id: @post.id)
    render status: 200
  end

  def destroy
    favorite = Favorite.find_by(user_id: session_user.id, post_id: @post.id)
    favorite.destroy
    render status: 204
  end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
  end
end
