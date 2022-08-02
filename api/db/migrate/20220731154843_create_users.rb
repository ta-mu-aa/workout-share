class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    create_table :users, id: :string do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :password_confirmation

      t.timestamps
    end
  end
end
