class FinallySortOutRelationshipBetweenUsersAndTokens < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :token
    Token.delete_all
  end
end
