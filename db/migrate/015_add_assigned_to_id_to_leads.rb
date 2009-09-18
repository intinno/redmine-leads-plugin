class AddAssignedToIdToLeads < ActiveRecord::Migration
  def self.up
    add_column :leads, :assigned_to_id, :integer
  end

  def self.down
    remove_column :leads, :assigned_to_id
  end
end
