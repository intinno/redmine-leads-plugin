class Org < ActiveRecord::Base

  CATEGORIES = ["College", "School", "Coaching", "Institute", "Publishing House", "Government Organization", "Company"]
  has_many :leads
  acts_as_paranoid

  validates_presence_of :name
  validates_presence_of :location
  validates_format_of   :email,     :with => /^([^@\,\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :if => :email?

  format_attributes ["contact_details"]
end
