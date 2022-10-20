class User < ApplicationRecord
  include TokenGenerateService   # Token生成モジュール
 # アソシエーション
  has_many :posts

  before_create :set_uuid
  has_secure_password

  validates :name, presence: true,      
                      length: { maximum: 30 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: true }, 
                      length: { maximum: 100 },
                      format: { with: VALID_EMAIL_REGEX }

  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, confirmation: true, presence: true,
                      length: { minimum: 8, maximum: 100 },
                      format: { with: VALID_PASSWORD_REGEX }
  validates :password_confirmation, presence: true

  # リフレッシュトークンのJWT IDを記憶する
  def remember(jti)
    update_column(:refresh_jti, jti)
  end

  # リフレッシュトークンのJWT IDを削除する
  def forget
    update_column(:refresh_jti, nil)
  end

  def response_json(payload = {})
    as_json(only: [:id, :name, :email]).merge(payload).with_indifferent_access
  end
  
  private
    def set_uuid
      # id未設定、またはすでに同じidのレコードが存在する場合はループに入る
      while self.id.blank? || User.find_by(id: self.id).present? do
        # ランダムな20文字をidに設定
        self.id = SecureRandom.alphanumeric(20)
      end
    end
end
