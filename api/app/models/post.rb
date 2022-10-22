class Post < ApplicationRecord
  # アソシエーション
  belongs_to :user

  validates :body, presence: true,      
                      length: { maximum: 400 }
  validates :user_id, presence:true
  validate :confirm_user_id
   
# ユーザーIDが登録されているユーザーのものか確認
  def confirm_user_id
    unless User.find_by(id: user_id)
      errors.add(:user_id, "ユーザーが存在しません")
    end
  end
 end
