class RemoveLeadWatchableFromRoles < ActiveRecord::Migration
  def self.up
    remove_column :roles, :leads_watchable
  end
  
  def self.down
    add_column :roles, :leads_watchable, :integer, :default => 0 
  end

end
