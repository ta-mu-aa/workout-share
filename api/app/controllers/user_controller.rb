class UserController < ApplicationController
  include UserSessionizeService
  before_action :sessionize_user

  def index
    render json: current_user.as_json(only: [:id, :name, :email, :created_at])
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
    updated_user = User.find_by(id: user_update_params[:id])
    if !user_update_params[:password] # パスワードの更新をしない場合
      updated_user.name, updated_user.email, updated_user.user_discription = user_update_params[:name], user_update_params[:email], user_update_params[:user_discription]
      if updated_user.save(context: :no_update_password) # バリデーションをかけない
        render status: 204
      else
        render_updated_errors(updated_user)
      end
    else
      if updated_user.update(user_update_params)
        render status: 204
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
    params.permit(:id, :user, :name, :email, :password, :password_confirmation, :user_discription)
  end

  def render_updated_errors(updated_user)
    if updated_user.errors[:email] === ["has already been taken"]
      render json: { message: '既に登録さているメールアドレスです', data: user.errors[:email] }, status: 409
    else
      render json: { mesage: '正確な情報を入力してください', data: updated_user.errors }, status: 400
    end
  end
end
