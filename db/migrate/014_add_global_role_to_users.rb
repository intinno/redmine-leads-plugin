class AddGlobalRoleToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :global_role_id, :integer
  end

  def self.down
    remove_column :users, :global_role_id
  end
end
