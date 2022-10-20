class PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    @post.save
  end

  def index
    @post = Post.all
    render json: @post
  end

  def show
    @post = Post.find(params[:id])
  end

  private
    def post_params
      params.require(:post).permit(:body, :user_id)
    end
end
