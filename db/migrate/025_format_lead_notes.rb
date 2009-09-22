class FormatLeadNotes < ActiveRecord::Migration
  def self.up
    add_column :lead_notes, :response_html,             :text
    add_column :lead_notes, :quote_given_html,          :text
    add_column :lead_notes, :docs_sent_html,            :text
    add_column :lead_notes, :features_interested_html,  :text
    add_column :lead_notes, :customizations_html,        :text
    add_column :lead_notes, :issues_html,               :text
    add_column :lead_notes, :existing_systems_html,     :text
  end
  
  def self.down
    remove_column :lead_notes, :response_html
    remove_column :lead_notes, :quote_given_html
    remove_column :lead_notes, :docs_sent_html
    remove_column :lead_notes, :features_interested_html
    remove_column :lead_notes, :cutomizations_html
    remove_column :lead_notes, :issues_html
    remove_column :lead_notes, :existing_systems_html
  end
end
