class LeadNote < ActiveRecord::Base

  #asociations
  belongs_to :lead
  belongs_to :author,           :class_name => "User"
  belongs_to :preceding_event,  :class_name => "LeadNote", :foreign_key => "parent_id"
  belongs_to :corresponder,     :class_name => "User"
  has_one    :followup_event,   :class_name => "LeadNote", :foreign_key => "parent_id"

  #extensions

  #validations
  validates_presence_of :date

  #constants
  CATEGORIES =      ["Meeting", "Phone Call", "Email", "Demo", "Quote"]
  RESPONSE_TYPES =  ["Not Interested At All", "Currently Not Interested", "No Reaction", "Moderately Interested", "Very Interested"]
  DATA_ATTRIBUTES = [ "response", "existing_systems", "quote_given", "docs_sent", "features_interested", "customizations", "issues"]

  format_attributes DATA_ATTRIBUTES

  def corresponder_name 
    corresponder.name rescue ""
  end

  def followup_event=(attributes)
    create_or_update_association("followup_event", attributes)
  end

  def attributes_entered
    data_entered = []

    (["corresponded_to", "corresponder_name"] + DATA_ATTRIBUTES + ["other_details"]).each do |attribute|
      begin 
        value = self.send("#{attribute}_html")
      rescue 
        value = self.send("#{attribute}")
      end
      data_entered << [attribute, value] unless value.blank?
    end

    data_entered
  end

  def summary(with_time = false)
    format = with_time ? "%A, %d %B %H:%M:%S" : "%A, %d %B"
    short_date = date.strftime(format)
    "#{category} on #{short_date}"
  end

  def visible_to?(user)
    user.eql?(self.author) || (self.lead && self.lead.visible_to?(user))
  end

  def not_visible_to?(user)
    !visible_to?(user)
  end

  def self.search(options)
    state = options["note_state"]
    type  = options["note_type"] 
    from  = options["note_from"]
    to    = options["note_to"]

    conditions = []
    conditions << "state = '#{state}'" unless state.blank?
    conditions << "category = '#{type}'" unless type.blank?
    conditions << "date >= '#{from}'" unless from.blank?
    conditions << "date <= '#{to}'" unless to.blank?

    notes = LeadNote.find(:all, :conditions => conditions.join(" AND "), :include => [:lead,  :author])
#    notes.reject{|n| if self.not_visible_to?(User.current)}
  end
end
