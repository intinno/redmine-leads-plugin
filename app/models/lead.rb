class Lead < ActiveRecord::Base

  has_many :leads_projects, :dependent => :destroy
  has_many :projects, :through => :leads_projects

  # name or company is mandatory
  validates_presence_of :name, :if => :company_unsetted
  validates_presence_of :company, :if => :name_unsetted
  validates_uniqueness_of :name, :scope => :company

  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, 
    :allow_nil => true, :allow_blank => true
  #TODO validate website address
  #TODO validate skype_name contact
  
   def pretty_name
     result = []
     [self.name, self.company].each do |field|
       result << field unless field.blank?
     end
     
     return result.join(", ")
   end
  

  def project_ids(force_reload = false)
    self.leads_projects(force_reload).collect{|lp| lp.project_id}
  end

  def project_ids=(ids)
    #remove the blank ids
    ids.reject!{|i| i.blank?}

    existing_project_ids = self.project_ids(true) 
    joins = self.leads_projects(true)

    #delete joins
    (existing_project_ids - ids).each do |id|
      join = joins.detect{|j| j.project_id == id}
      join.destroy
    end

    #create new joins
    (ids - existing_project_ids).each do |id|
      self.leads_projects.create(:project_id => id)
    end
  end
  private
  
  def name_unsetted
    self.name.blank?
  end
  
  def company_unsetted
    self.company.blank?
  end

end
