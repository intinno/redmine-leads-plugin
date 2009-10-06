class AddCorrespondanceToLeadNote  < ActiveRecord::Migration
  def self.up
    add_column :lead_notes, :corresponded_to, :string
    add_column :lead_notes, :corresponder_id, :integer
  end
  
  def self.down
    remove_column :lead_notes, :corresponded_to
    remove_column :lead_notes, :corresponder_id
  end
end
