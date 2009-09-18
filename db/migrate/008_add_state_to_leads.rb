class AddStateToLeads < ActiveRecord::Migration
  def self.up
    add_column :leads, :state, :string
  end

  def self.down
    remove_column :leads, :state
  end
end
