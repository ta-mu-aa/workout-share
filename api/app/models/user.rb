class User < ApplicationRecord
  include TokenGenerateService   # Token生成モジュール
  include Rails.application.routes.url_helpers 
 # アソシエーション
  has_many :posts
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  has_secure_password
  has_one_attached :image_icon # Active Recordによる疑似カラム生成
  attr_accessor :image

  before_create :set_uuid

  validates :name, presence: true,      
                      length: { maximum: 30 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: true }, 
                      length: { maximum: 100 },
                      format: { with: VALID_EMAIL_REGEX }

  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, confirmation: true, presence: true, on: :password,
                      length: { minimum: 8, maximum: 100 },
                      format: { with: VALID_PASSWORD_REGEX }
  validates :password_confirmation, presence: true, on: :password_confirmation

  validates :user_discription,
                      length: { maximum: 400}

  # リフレッシュトークンのJWT IDを記憶する
  def remember(jti)
    update_column(:refresh_jti, jti)
  end

  # リフレッシュトークンのJWT IDを削除する
  def forget
    update_column(:refresh_jti, nil)
  end

  def response_json(payload = {})
    as_json(only: [:id, :name, :email, :user_discription], methods: :image_url).merge(payload).with_indifferent_access
  end

  # 紐づいている画像のURLを取得する
  def image_url
    image_icon.attached? ? url_for(image_icon) : nil
  end

  def parse_base64(updated_user,image)
    if image.present? || rex_image(image) == ''
      content_type = create_extension(image)
      contents = image.sub %r/data:((image|application)\/.{3,}),/, ''
      decoded_data = Base64.decode64(contents)
      filename = Time.zone.now.to_s + '.' + content_type
      File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
        f.write(decoded_data)
      end
    end
    attach_image(updated_user,filename)
  end

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
  
  private
    def set_uuid
      # id未設定、またはすでに同じidのレコードが存在する場合はループに入る
      while self.id.blank? || User.find_by(id: self.id).present? do
        # ランダムな20文字をidに設定
        self.id = SecureRandom.alphanumeric(20)
      end
    end

    def create_extension(image)
      content_type = rex_image(image)
      content_type[%r/\b(?!.*\/).*/]
    end

    def rex_image(image)
      image[%r/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/]
    end

    def attach_image(updated_user,filename)
      updated_user.image_icon.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
      FileUtils.rm("#{Rails.root}/tmp/#{filename}")
    end
end
