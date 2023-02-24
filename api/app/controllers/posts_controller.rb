class PostsController < ApplicationController
  include UserSessionizeService
  before_action :sessionize_user
  
  def create
    post = Post.new(post_params)
    if post.save
      render json: post
    else
      if post.errors["body"] === ["is too long (maximum is 400 characters)"]
        render json: { message: '400字以内で入力してください', data: post.errors["body"]}, status:400
      elsif post.errors["body"] === ["can't be blank"]
        render json: { message: '文字を入力してください', data: post.errors["body"] }, status:400    
      else 
        render json: { message: '投稿元のユーザーが見つかりませんでした', data: post.errors }, status: 404
      end
    end
  end

  def index
    fetch_post = Post.all
    add_username_post_all = fetch_post_list(fetch_post)
    render json: add_username_post_all
  end

  def individual_post
    fetch_post = Post.where(user_id: params[:id])
    individual_post = fetch_post_list(fetch_post)
    render json: individual_post
  end

  def show
    post_unique = Post.find(params[:id])
    render json: post_unique
  end

  def update
    update_post = Post.find(params[:id])
    if update_post.update(post_params)
      render json: { message: '投稿内容の更新に成功しました', data: update_post }, status:201
    else 
      if update_post.errors["body"] === ["is too long (maximum is 400 characters)"]
        render json: { message: '400字以内で入力してください', data: update_post.errors["body"] }, status:400
      elsif update_post.errors["body"] === ["can't be blank"]
        render json: { message: '文字を入力してください', data: update_post.errors["body"] }, status:400    
      else 
        render json: { message: '投稿が見つかりませんでした', data: update_post.errors["body"] }, status: 404
      end
    end
  end

  def destroy
    destroy_post = Post.find(params[:id])
    destroy_post.destroy
    render status:204
  end

  private
    def post_params
      params.require(:post).permit(:body, :user_id)
    end

    def fetch_post_list(fetch_post)
      fetch_post.map do |post|
        posted_user = User.find_by(id: post[:user_id])
        {
          "id" => post.id, "body" => post.body, "created_at" => post.created_at, "updated_at" => post.updated_at,
          "user_id" => post.user_id, "user_name" => posted_user.name, "image_icon" => posted_user.image_url
        }
      end
    end
end
