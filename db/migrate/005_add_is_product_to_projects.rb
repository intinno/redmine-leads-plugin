class AddIsProductToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :is_product, :integer, :default => 0
  end

  def self.down
    remove_column :projects, :is_product
  end
end
