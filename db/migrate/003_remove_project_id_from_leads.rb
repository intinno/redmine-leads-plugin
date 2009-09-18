class RemoveProjectIdFromLeads < ActiveRecord::Migration
  def self.up
    remove_column :leads, :project_id
  end

  def self.down
    add_column :leads, :project_id, :integer
  end
end
