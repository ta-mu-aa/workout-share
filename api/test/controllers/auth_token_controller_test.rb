require 'test_helper'

class AuthTokenControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = active_user
    @params = { auth: { email: @user.email, password: "password00" } }
    @access_lifetime = UserAuth.access_token_lifetime
    @refresh_lifetime = UserAuth.refresh_token_lifetime
    @session_key = UserAuth.session_key.to_s
    @access_token_key = "token"
  end

  # 無効なリクエストで返ってくるレスポンスチェック
  def response_check_of_invalid_request(status, error_msg = nil)
    assert_response status
    @user.reload
    assert_nil @user.refresh_jti
    assert_not response.body.present? if error_msg.nil?
    assert_equal error_msg, res_body["error"] if !error_msg.nil?
  end

  test "有効なログインの場合" do
    login(@params)
    assert_response 200
    access_lifetime_to_i = @access_lifetime.from_now.to_i
    refresh_lifetime_to_i = @refresh_lifetime.from_now.to_i
    
    # jtiは保存されているか
    @user.reload
    assert_not_nil @user.refresh_jti

    # レスポンスユーザーは正しいか
    assert_equal @user.id, res_body["user"]["id"]

    # レスポンス有効期限は想定通りか(1誤差許容)
    assert_in_delta access_lifetime_to_i,
                    res_body["expires"],
                    1

    ## access_token取得
    access_token = User.decode_access_token(res_body[@access_token_key])

    # ユーザーはログイン本人と一致しているか
    assert_equal @user, access_token.entity_for_user

    # 有効期限はレスポンスと一致しているか
    token_exp = access_token.payload["exp"]
    assert_equal res_body["expires"], token_exp

    ## cookieの取得
    cookie = @request.cookie_jar.
             instance_variable_get(:@set_cookies)[@session_key]

    # expiresは想定通りか(1秒許容)
    assert_in_delta Time.at(refresh_lifetime_to_i),
                    cookie[:expires],
                    1.seconds

    # secureは一致しているか
    assert_equal Rails.env.production?, cookie[:secure]

    # http_onlyはtrueか
    assert cookie[:http_only]

    ## refresh_token取得
    token_from_cookies = cookies[@session_key]
    refresh_token = User.decode_refresh_token(token_from_cookies)
    @user.reload

    # ログイン本人と一致しているか
    assert_equal @user, refresh_token.entity_for_user

    # jtiは一致しているか
    assert_equal @user.refresh_jti, refresh_token.payload["jti"]

    # token有効期限とcookie有効期限は一致しているか
    assert_equal refresh_lifetime_to_i, refresh_token.payload["exp"]
  end

  test "無効なログインの場合" do
    # 不正なユーザーの場合
    pass = "password"
    invalid_params = { auth: { email: @user.email, password: pass + "a" } }
    login(invalid_params)
    response_check_of_invalid_request 404
  end

  test "有効なトークンリフレッシュの場合" do
    # 有効なログイン
    login(@params)
    assert_response 200
    @user.reload
    old_access_token = res_body[@access_token_key]
    old_refresh_token = cookies[@session_key]
    old_user_jti = @user.refresh_jti

  #  ログイン時のトークンを確認
    assert_not_nil old_access_token
    assert_not_nil old_refresh_token
    assert_not_nil old_user_jti

    # refreshアクションを実行
    refresh_api
    assert_response 200
    @user.reload
    new_access_token = res_body[@access_token_key]
    new_refresh_token = cookies[@session_key]
    new_user_jti = @user.refresh_jti

    # 新規発行したトークンがnilでないか
    assert_not_nil new_access_token
    assert_not_nil new_refresh_token
    assert_not_nil new_user_jti

    # tokenとjtiがログイン時から変化しているか
    assert_not_equal old_access_token, new_access_token
    assert_not_equal old_refresh_token, new_refresh_token
    assert_not_equal old_user_jti, new_user_jti

    # user.refresh_jtiが最新のjtiと一致しているか
    payload = User.decode_refresh_token(new_refresh_token).payload
    assert_equal payload["jti"], new_user_jti
  end

  test "無効なトークンリフレッシュの場合" do
    # refresh_tokenが存在しない場合はアクセスできないか
    refresh_api
    response_check_of_invalid_request 401

    ## ユーザーが2回のログインを行なった場合
    # 1回目ログイン
    login(@params)
    assert_response 200
    old_refresh_token = cookies[@session_key]

    # 2回目ログイン(他のブラウザおよび別タブ想定)
    login(@params)
    assert_response 200
    new_refresh_token = cookies[@session_key]

    # cookieに古いrefresh_tokenをセット
    cookies[@session_key] = old_refresh_token
    assert_not cookies[@session_key].blank?

    # 1つ目のログイン(古いrefresh_token)でアクセスするとエラーを返すか
    refresh_api
    assert_response 401

    # cookieは削除されているか
    assert cookies[@session_key].blank?

    # 有効期限後はアクセスできないか
    travel_to (@refresh_lifetime.from_now) do
      refresh_api
      assert_response 401
      assert_not response.body.present?
    end
  end

  test "ログアウト時" do
    # まず有効なログインを行う
    login(@params)
    assert_response 200
    @user.reload
    assert_not_nil @user.refresh_jti
    assert_not_nil @request.cookie_jar[@session_key]

    # 有効なログアウト
    assert_not cookies[@session_key].blank?
    logout
    assert_response 200

    # cookieは削除されているか
    assert cookies[@session_key].blank?

    # userのjtiは削除できているか
    @user.reload
    assert_nil @user.refresh_jti

    # sessionがない状態でログアウトしたらエラーは返ってくるか
    cookies[@session_key] = nil
    logout
    response_check_of_invalid_request 401

    # 有効なログイン
    login(@params)
    assert_response 200
    assert_not cookies[@session_key].blank?

    # session有効期限後にログアウトしたらエラーは返ってくるか
    travel_to (@refresh_lifetime.from_now) do
      logout
      assert_response 401
      assert cookies[@session_key].blank?
    end
  end
end
