class ChangeDateToDatetimeInLeads < ActiveRecord::Migration
  def self.up
    change_column :lead_notes, :date, :datetime
  end

  def self.down
    change_column :lead_notes, :datetime, :date
  end
end
