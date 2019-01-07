class ReallyFinallySortOutRelationshipBetweenUsersAndTokens < ActiveRecord::Migration[5.2]
  def change
    remove_column :tokens, :user_id
    add_column :users, :token_id, :integer
  end
end
