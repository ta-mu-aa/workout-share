class UserController < ApplicationController
  def index
    render json:{data: "data"}, status:200
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { id:user.id, name:user.name, email:user.email }, status:201
    else
      if user.errors[:email] === ["has already been taken"]
        render json: { message: '既に登録されています', data: user.errors[:email] }, status: 409
      else
        render json: { message: '正しく入力してください', data: user.errors}, status: 400
      end
    end
  end

  def update
  end

  def delete
  end

  private 
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end