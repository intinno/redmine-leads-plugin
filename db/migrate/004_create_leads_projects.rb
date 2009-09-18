class CreateLeadsProjects < ActiveRecord::Migration
  def self.up
    create_table :leads_projects do |t|
      t.integer :project_id
      t.integer :lead_id
      t.timestamps
      t.datetime :deleted_at
    end
  end
  
  def self.down
    drop_table :leads_projects
  end
end
