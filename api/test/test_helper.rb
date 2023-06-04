ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  parallelize_setup do |worker|
    # seedデータの読み込み
    load "#{Rails.root}/db/seeds.rb"
  end

  # 並列テストの有効化・無効化
  parallelize(workers: :number_of_processors)

  def active_user
    User.find_by(name: "ユーザー1")
  end

  def login(params)
    post "/auth_token", params: params
  end

  def logout
    delete "/auth_token"
  end

    def refresh_api
      post "/auth_token/refresh"
    end

  # レスポンスJSONをハッシュで返す
  def res_body
    JSON.parse(@response.body)
  end

end
