module UserAuthenticateService
  # 認証する際トークンの持ち主が存在するか判定
  def authenticate_user
    current_user.present? || unauthorized_user
  end

  # トークンの持ち主かつメール認証ユーザーをが存在するか判定
  def authenticate_active_user
    (current_user.present? && current_user.activated?) || unauthorized_user
  end

  private

    # リクエストヘッダートークンを取得する
    def token_from_request_headers
      request.headers["Authorization"]&.split&.last
    end

    # access_tokenから有効なユーザーを取得する
    def fetch_user_from_access_token
      User.from_access_token(token_from_request_headers)
    rescue UserAuth.not_found_exception_class,
           JWT::DecodeError, JWT::EncodeError
      nil
    end

    # tokenのユーザーを返す
    def current_user
      return nil unless token_from_request_headers
      @_current_user ||= fetch_user_from_access_token
    end

    # 認証エラー
    def unauthorized_user
      cookies.delete(UserAuth.session_key)
      head(:unauthorized)
    end
end
