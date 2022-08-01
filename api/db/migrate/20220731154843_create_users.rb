class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :string do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :confirmpassword

      t.timestamps
    end
  end
end
