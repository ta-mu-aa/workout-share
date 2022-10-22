class PostsController < ApplicationController

  def create
    post = Post.new(post_params)
    if post.save
      render json: post
    else
      if post.errors === ["is too long (maximum is 400 characters)"]
        render json: { message: '400字以内で入力してください', data: post.errors["body"]}, status:400
      elsif post.errors === ["can't be blank"]
        render json: { message: '文字を入力してください', data: post.errors["body"] }, status:400    
      else 
        render json: { message: '投稿元のユーザーが見つかりませんでした', data: post.errors }, status: 404
      end
    end
  end

  def index
    post_all = Post.all
    render json: post_all
  end

  def show
    post_unique = Post.find(params[:id])
    render json: post_unique
  end

  private
    def post_params
      params.require(:post).permit(:body, :user_id)
    end
end
