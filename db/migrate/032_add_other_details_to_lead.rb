class AddOtherDetailsToLead < ActiveRecord::Migration
  def self.up
    add_column :lead_notes, :other_details, :text
  end
  
  def self.down
    remove_column :lead_notes, :other_details, :text
  end
end
