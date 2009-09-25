class AddContactDetailsHtmlToOrg < ActiveRecord::Migration
  def self.up
    remove_column :lead_notes, :contact_details_html
    add_column :orgs, :contact_details_html, :text
  end
  
  def self.down
    add_column :lead_notes, :contact_details_html, :text
    remove_column :orgs, :contact_details_html
  end
end
