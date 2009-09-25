class AddContactDetailsHtml < ActiveRecord::Migration
  def self.up
    add_column :lead_contacts, :contact_details_html, :text
    add_column :lead_notes, :contact_details_html, :text
  end
  
  def self.down
    remove_column :lead_notes, :contact_details_html
    remove_column :lead_contacts, :contact_details_html
  end
end
