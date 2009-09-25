class LeadNote < ActiveRecord::Base

  #asociations
  belongs_to :lead
  belongs_to :author, :class_name => "User"

  #extensions

  #validations
  validates_presence_of :date

  #constants
  CATEGORIES =      ["Meeting", "Phone Call", "Email", "Demo", "Quote"]
  RESPONSE_TYPES =  ["Not Interested At All", "Currently Not Interested", "No Reaction", "Moderately Interested", "Very Interested"]
  DATA_ATTRIBUTES = ["response", "existing_systems", "quote_given", "docs_sent", "features_interested", "customizations", "issues"]

  format_attributes DATA_ATTRIBUTES

  def attributes_entered
    data_entered = []

    (DATA_ATTRIBUTES + ["other_details"]).each do |attribute|
      begin 
        value = self.send("#{attribute}_html")
      rescue 
        value = self.send("#{attribute}")
      end
      data_entered << [attribute, value] unless value.blank?
    end

    data_entered
  end

  def summary
    short_date = date.strftime("%a %b %d")
    "#{category} on #{short_date}"
  end

end
