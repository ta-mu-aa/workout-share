module UserSessionizeService

  # セッションユーザーが居ればtrue、存在しない場合は401を返す
  def sessionize_user
    session_user.present? || unauthorized_user
  end

  # セッションキー
  def session_key
    UserAuth.session_key
  end

  # セッションcookieを削除する
  def delete_session
    cookies.delete(session_key)
  end

  private

    # cookieのtokenを取得
    def token_from_cookies
      cookies[session_key]
    end

    # refresh_tokenから有効なユーザーを取得する
    def fetch_user_from_refresh_token
      User.from_refresh_token(token_from_cookies)
    rescue UserAuth.not_found_exception_class,
           JWT::DecodeError, JWT::EncodeError
      nil
    end

    # refresh_tokenのユーザーを返す
    def session_user
      return nil unless token_from_cookies
      @_session_user ||= fetch_user_from_refresh_token
    end

    # 認証エラー
    def unauthorized_user
      delete_session
      head(:unauthorized)
    end
end
