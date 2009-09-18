class AddDeletedAtToLeads < ActiveRecord::Migration
  def self.up
    add_column :leads, :deleted_at, :datetime
  end

  def self.down
    remove_column :leads, :deleted_at
  end
end
