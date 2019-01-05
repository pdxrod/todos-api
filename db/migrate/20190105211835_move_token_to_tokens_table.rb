class MoveTokenToTokensTable < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :token
      t.integer :user_id

      t.timestamps
    end
    remove_column :users, :token
  end
end
