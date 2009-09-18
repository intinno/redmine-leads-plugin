class AddStateIdToLeads < ActiveRecord::Migration
  def self.up
    remove_column :leads, :state
    add_column :leads, :state_id, :integer

    remove_column :orgs, :category
    add_column :orgs, :category_id, :integer
  end

  def self.down
    add_column :leads, :state, :string
    remove_column :leads, :state_id

    add_column :orgs, :category, :string
    remove_column :orgs, :category_id
  end
end
