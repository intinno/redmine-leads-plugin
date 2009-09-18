class RemoveStateFromLeads < ActiveRecord::Migration
  def self.up
    add_column :leads, :state, :string
    remove_column :leads, :state_id

    add_column :orgs, :category, :string
    remove_column :orgs, :category_id
  end

  def self.down
    remove_column :leads, :state
    add_column :leads, :state_id, :integer

    remove_column :orgs, :category
    add_column :orgs, :category_id, :integer
  end
end
