class AddParentIdToLeadNote  < ActiveRecord::Migration
  def self.up
    add_column :lead_notes, :parent_id, :integer
  end
  
  def self.down
    remove_column :lead_notes, :parent_id
  end
end
