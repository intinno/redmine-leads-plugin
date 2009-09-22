class CreateLeadNotes < ActiveRecord::Migration
  def self.up
    create_table :lead_notes do |t|
      t.timestamps
      t.datetime :deleted_at
      t.date :date
      t.string :category, :response
      t.text :existing_systems, :quote_given, :docs_sent 
      t.text :features_interested, :customizations, :issues
    end
  end
  
  def self.down
    drop_table :lead_notes
  end
end
