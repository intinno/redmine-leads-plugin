class AddAuthorAndLeadToLeadContacts < ActiveRecord::Migration
  def self.up
    add_column :lead_contacts, :author_id, :integer
    add_column :lead_contacts, :lead_id, :integer
  end
  
  def self.down
    remove_column :lead_contacts, :author_id
    remove_column :lead_contacts, :lead_id
  end
end
