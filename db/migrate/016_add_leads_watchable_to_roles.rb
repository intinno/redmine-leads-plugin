class AddLeadsWatchableToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :leads_watchable, :boolean, :default => true
  end

  def self.down
    remove_column :roles, :leads_watchable
  end
end
