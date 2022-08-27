class AuthTokenController < ApplicationController
  include UserSessionizeService
 
  rescue_from UserAuth.not_found_exception_class, with: :not_found
  rescue_from JWT::InvalidJtiError, with: :invalid_jti

  before_action :authenticate, only: [:create]
  before_action :delete_session, only: [:create]
  before_action :sessionize_user, only: [:refresh, :destroy]

  # ログイン
  def create  
    @user = login_user
    set_refresh_token_to_cookie
    render json: login_response
  end

  # リフレッシュ
  def refresh
    @user = session_user
    set_refresh_token_to_cookie
    render json: login_response
  end

  # ログアウト
  def destroy
    delete_session if session_user.forget
    cookies[session_key].nil? ?
      head(:ok) : response_500("Could not delete session")
  end 

  private

   # params[:email]からアクティブなユーザーを返す
   def login_user
     @_login_user ||= User.find_by(email:auth_params[:email])
   end

   # ログインユーザーが居ない、もしくはpasswordが一致しない場合404を返す
   def authenticate
     unless login_user.present? &&
            login_user.authenticate(auth_params[:password])
       raise UserAuth.not_found_exception_class
     end
   end

   # refresh_tokenをcookieにセットする
   def set_refresh_token_to_cookie
     cookies[session_key] = {
       value: refresh_token,
       expires: refresh_token_expiration,
       secure: Rails.env.production?,
       http_only: true
     }
   end

   # ログイン時のデフォルトレスポンス
   def login_response
     {
       token: access_token,
       expires: access_token_expiration,
       user: @user.response_json(sub: access_token_subject)
     }
   end

   # リフレッシュトークンのインスタンス生成
   def encode_refresh_token
     @_encode_refresh_token ||= @user.encode_refresh_token
   end

   # リフレッシュトークン
   def refresh_token
     encode_refresh_token.token
   end

   # リフレッシュトークンの有効期限
   def refresh_token_expiration
     Time.at(encode_refresh_token.payload[:exp])
   end

   # アクセストークンのインスタンス生成
   def encode_access_token
     @_encode_access_token ||= @user.encode_access_token
   end

   # アクセストークン
   def access_token
     encode_access_token.token
   end

   # アクセストークンの有効期限
   def access_token_expiration
     encode_access_token.payload[:exp]
   end

   # アクセストークンのsubjectクレーム
   def access_token_subject
     encode_access_token.payload[:sub]
   end

   def not_found
     head(:not_found)
   end

   def invalid_jti
     msg = "Invalid jti for refresh token"
     render status: 401, json: { status: 401, error: msg }
   end

   def auth_params
     params.require(:auth).permit(:email, :password)
   end
end
