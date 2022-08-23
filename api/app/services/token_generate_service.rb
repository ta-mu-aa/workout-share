module TokenGenerateService
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    # アクセストークンのインスタンス生成(オプション => sub: encrypt user id)
    def decode_access_token(token, options = {})
      UserAuth::AccessToken.new(token: token, options: options)
    end

    # アクセストークンのuserを返す
    def from_access_token(token, options = {})
      decode_access_token(token, options).entity_for_user
    end

    # リフレッシュトークンのインスタンス生成
    def decode_refresh_token(token)
      UserAuth::RefreshToken.new(token: token)
    end

    # リフレッシュトークンのuserを返す
    def from_refresh_token(token)
      decode_refresh_token(token).entity_for_user
    end

  end

  # アクセストークンのインスタンス生成
  def encode_access_token(payload = {})
    UserAuth::AccessToken.new(user_id: id, payload: payload)
  end

  # アクセストークンを返す(期限変更 => lifetime: 10.minute)
  def to_access_token(payload = {})
    encode_access_token(payload).token
  end

  # リフレッシュトークンのインスタンス生成
  def encode_refresh_token
    UserAuth::RefreshToken.new(user_id: id)
  end

  # リフレッシュトークンを返す
  def to_refresh_token
    encode_refresh_token.token
  end

end
