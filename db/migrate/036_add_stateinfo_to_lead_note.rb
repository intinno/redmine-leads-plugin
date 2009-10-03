class AddStateinfoToLeadNote  < ActiveRecord::Migration
  def self.up
    add_column :lead_notes, :state, :string
    remove_column :lead_contacts, :state
  end
  
  def self.down
    add_column :lead_contacts, :state, :string
    remove_column :lead_notes, :state
  end
end
