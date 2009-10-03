class AddStateToLeadNote  < ActiveRecord::Migration
  def self.up
    add_column :lead_contacts, :state, :string
  end
  
  def self.down
    remove_column :lead_contacts, :state
  end
end
