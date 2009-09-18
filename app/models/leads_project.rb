class LeadsProject < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :lead
  belongs_to :project
end
