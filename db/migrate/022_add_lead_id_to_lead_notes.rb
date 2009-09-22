class AddLeadIdToLeadNotes < ActiveRecord::Migration
  def self.up
    add_column :lead_notes, :lead_id, :integer
  end

  def self.down
    remove_column :lead_notes, :lead_id
  end
end
