class AddTimestampsToLead < ActiveRecord::Migration
  def self.up
    add_column :leads, :created_at, :datetime
    add_column :leads, :updated_at, :datetime
  end

  def self.down
    remove_column :leads, :created_at
    remove_column :leads, :updated_at
  end
end
