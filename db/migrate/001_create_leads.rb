# Use rake db:migrate_plugins to migrate installed plugins
class CreateLeads < ActiveRecord::Migration
  def self.up
    create_table :leads do |t|
      t.column :name,       :string
      t.column :company,    :string
      t.column :address,    :text
      t.column :phone,      :string
      t.column :email,      :string
      t.column :website,    :string
      t.column :skype_name, :string
    end
  end

  def self.down
    drop_table :leads
  end
end
