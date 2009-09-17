# Use rake db:migrate_plugins to migrate installed plugins
class LinkLeadsToProjects < ActiveRecord::Migration
  def self.up
    add_column :leads, :project_id, :integer    
  end

  def self.down
    remove_column :leads, :project_id
  end
end
