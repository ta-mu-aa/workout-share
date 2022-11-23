class ChangeDataColumnToVarchar < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :user_discription, :text
  end
end
