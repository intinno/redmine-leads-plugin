class AddAuthorIdToLeads < ActiveRecord::Migration
  def self.up
    add_column :leads, :author_id, :integer
  end

  def self.down
    remove_column :leads, :author_id
  end
end
