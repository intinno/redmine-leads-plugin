class AddLeadsAssignableToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :leads_assignable, :boolean, :default => true
  end

  def self.down
    remove_column :roles, :leads_assignable
  end
end
