class CreateLeadContacts < ActiveRecord::Migration
  def self.up
    create_table :lead_contacts do |t|
      t.string :name
      t.text :city
      t.text :contact_details
      t.string :email
      t.string :website
      t.timestamps
      t.datetime :deleted_at
    end
  end
  
  def self.down
    drop_table :lead_contacts
  end
end
