class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }, type: :string 
      t.references :followed, null: false, foreign_key: { to_table: :users }, type: :string 

      t.timestamps
    end
  end
end
