class Lead < ActiveRecord::Base

  #aasociations
  has_many :leads_projects, :dependent => :destroy
  has_many :projects, :through => :leads_projects
  belongs_to :org
  belongs_to :author, :class_name => "User"
  belongs_to :assigned_to, :class_name => "User"

  #extensions
  acts_as_paranoid
  acts_as_watchable

  #attributes
  attr_accessor :org_name

  #constants
  STATES = ["New", "In Progess", "Converted", "Rejected", "Useless"]

  validates_associated :org, :message => "Organization Details are Invalid"

  def name
    self.org.name
  end

   def pretty_name
     name
   end

  def assignable_members
    User.active.find(:all, :include => [:global_role]).select{|m| m.global_role.leads_assignable?}.sort
  end

  def watching_members
    User.active.find(:all, :include => [:global_role]).select{|m| m.global_role.leads_watchable?}.sort
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
      self.build_or_create_association("leads_projects", :project_id => id)
    end
  end

  def org_attributes=(attrs)
    self.new_record? || self.org.nil? ?
      self.build_or_create_association("org", attrs) :
      self.org.update_attributes(attrs)
  end

end
