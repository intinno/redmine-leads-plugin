class AddInfoToContacts  < ActiveRecord::Migration
  def self.up
    add_column :lead_contacts, :mobile, :string
    add_column :lead_contacts, :landline, :string
    add_column :lead_contacts, :designation, :string
  end
  
  def self.down
    remove_column :lead_contacts, :mobile
    remove_column :lead_contacts, :landline
    remove_column :lead_contacts, :designation
  end
end
