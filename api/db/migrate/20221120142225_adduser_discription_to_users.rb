class AdduserDiscriptionToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_discription, :string
  end
end
