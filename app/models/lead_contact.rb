class LeadContact < ActiveRecord::Base

  #asociations
  belongs_to :lead
  belongs_to :author, :class_name => "User"

  #extensions

  #validations
  validates_presence_of :name
  validates_presence_of :city

  #constants
  DATA_ATTRIBUTES = ["email", "website", "contact_details"]

  format_attributes ["contact_details"]

  def attributes_entered
    data_entered = []
    DATA_ATTRIBUTES.each do |attribute|
      begin 
        value = self.send("#{attribute}_html")
      rescue
        value = self.send("#{attribute}")
      end
      data_entered << [attribute, value] unless value.blank?
    end
    data_entered
  end

  def self.search(options)

    #prepare the conditions to serach contacts
    conditions = []
    ["name", "city", "email", "website", "contact_details"].each do |attr_name|
      attr_value = options["#{attr_name}"]
      unless attr_value.blank?
        conditions << "#{attr_name} like '%#{attr_value}%'"
      end
    end

    #find and filetr contacts
    contacts = LeadContact.find(:all, :conditions => conditions.join(" AND "))
    contacts.reject{|c| c.not_visible_to?(User.current)}
  end

  def visible_to?(user)
    editable_by?(user) || 
    user.lead_contacts.include?(self)
  end

  def editable_by?(user)
    user.admin? ||
    self.author_id == user.id
  end

  def not_visible_to?(user)
    !visible_to?(user)
  end

  def not_editable_by?
    !editable_by?(user)
  end
end
