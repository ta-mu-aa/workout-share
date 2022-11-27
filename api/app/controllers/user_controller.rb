class UserController < ApplicationController
  include UserSessionizeService
  require 'base64'
  before_action :sessionize_user,  except: :create

  def index
    users = User.all
    render json: users, methods: [:image_url]
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { id:user.id, name:user.name, email:user.email }, status:201
    else
      if user.errors[:email] === ["has already been taken"]
        render json: { message: '既に登録されています', data: user.errors[:email] }, status: 409
      else
        render json: { message: '正確な情報を入力してください', data: user.errors}, status: 400
      end
    end
  end

  def update
    updated_user = User.find(user_update_params[:id])
    if !user_update_params[:password] # パスワードの更新をしない場合
      updated_user.parse_base64(updated_user, user_update_params[:image_icon]) if user_update_params[:image_icon]
      updated_user.name, updated_user.email, updated_user.user_discription = user_update_params[:name], user_update_params[:email], user_update_params[:user_discription]
      if updated_user.save(context: :no_update_password) # パスワードのカラムにバリデーションをかけない
        render_updated_success_response(updated_user)
      else
        render_updated_errors(updated_user)
      end
    else
      updated_user.parse_base64(updated_user, user_update_params[:image_icon]) if user_update_params[:image_icon]
      user_update_params_remove_image = {name:user_update_params[:name], email:user_update_params[:email], password:user_update_params[:password], user_discription:user_update_params[:user_discription]}
      if updated_user.update(user_update_params_remove_image)
        render_updated_success_response(updated_user)
      else
        render_updated_errors(updated_user)
      end
    end
  end

  def delete
  end

  private 
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def user_update_params
    params.permit(:id, :name, :email, :password, :password_confirmation, :user_discription, :image_icon)
  end

  def render_updated_success_response(updated_user)
    response_user_data = User.select("id", "name", "email", "user_discription").find(user_update_params[:id])
    render json: response_user_data, methods: :image_url
  end

  def render_updated_errors(updated_user)
    if updated_user.errors[:email] === ["has already been taken"]
      render json: { message: '既に登録さているメールアドレスです', data: user.errors[:email] }, status: 409
    else
      render json: { message: '正確な情報を入力してください', data: updated_user.errors }, status: 400
    end
  end
end
