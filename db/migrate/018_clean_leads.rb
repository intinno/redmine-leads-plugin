class CleanLeads < ActiveRecord::Migration
  def self.up
    remove_column :leads, :name
    remove_column :leads, :company
    remove_column :leads, :address
    remove_column :leads, :phone
    remove_column :leads, :email
    remove_column :leads, :website
    remove_column :leads, :skype_name
  end

  def self.down
  end
end
