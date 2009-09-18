class AddOrganizationIdToLeads < ActiveRecord::Migration
  def self.up
    add_column :leads, :org_id, :integer
  end

  def self.down
    remove_column :leads, :org_id
  end
end
