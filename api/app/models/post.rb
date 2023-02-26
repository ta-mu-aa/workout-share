class Post < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  before_create :set_post_uuid

  validates :body, presence: true,      
                      length: { maximum: 400 }
  validates :user_id, presence:true
  validate :confirm_user_id
   
  
  private
  # ユーザーIDが登録されているユーザーのものか確認
  def confirm_user_id
    unless User.find_by(id: user_id)
      errors.add(:user_id, "ユーザーが存在しません")
    end
  end

  def set_post_uuid
    # id未設定、またはすでに同じidのレコードが存在する場合はループに入る
    while self.id.blank? || Post.find_by(id: self.id).present? do
      # ランダムな数字をidに設定
      self.id = SecureRandom.random_number(1 << 32)
    end
  end
 end
