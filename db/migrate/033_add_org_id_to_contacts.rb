class AddOrgIdToContacts  < ActiveRecord::Migration
  def self.up
    add_column :lead_contacts, :org_id, :integer
  end
  
  def self.down
    remove_column :lead_contacts, :org_id
  end
end
