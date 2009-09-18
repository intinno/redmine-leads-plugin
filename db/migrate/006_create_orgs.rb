class CreateOrgs < ActiveRecord::Migration
  def self.up
    create_table :orgs do |t|
      t.string :name
      t.text :location
      t.string :category
      t.integer :head_count
      t.text :contact_details
      t.string :email
      t.string :website
      t.timestamps
      t.datetime :deleted_at
    end
  end
  
  def self.down
    drop_table :orgs
  end
end
