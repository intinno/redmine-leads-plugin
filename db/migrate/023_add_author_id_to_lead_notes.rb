class AddAuthorIdToLeadNotes < ActiveRecord::Migration
  def self.up
    add_column :lead_notes, :author_id, :integer
  end

  def self.down
    remove_column :lead_notes, :author_id
  end
end
