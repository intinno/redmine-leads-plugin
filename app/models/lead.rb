class Lead < ActiveRecord::Base

  #aasociations
  has_many    :leads_projects,  :dependent => :destroy
  has_many    :projects,        :through => :leads_projects
  has_many    :notes,           :class_name => "LeadNote"
  has_many    :contacts,        :class_name => "LeadContact"
  has_one     :latest_note,     :class_name => "LeadNote",    :order => "lead_notes.date DESC"

  belongs_to  :author,          :class_name => "User"
  belongs_to  :assigned_to,     :class_name => "User"

  #extensions
  acts_as_paranoid
  acts_as_watchable
  belongs_to_org

  #attributes

  #constants
  STATES = ["New", "In Progess", "Converted", "Rejected", "Useless"]

  validates_presence_of :org_id, :message => "Organization details cannot be empty", :unless => Proc.new{|lead| lead.org_attributes_submitted}

  #callbacks
  after_create :notify_watchers
  after_update :notify_watchers

  def notify_watchers
    suffix = self.created_at == self.updated_at ? "add" : "edit"
    LeadMailer.send("deliver_lead_#{suffix}", self)
  end

  def self.search(options)
    options["lead"] ||= {}
    options["org"] ||= {}
    options["location"] ||= {}

    org_name        = options["org"]["name"]
    org_location    = options["location"]["name"]
    product_id      = options["lead"]["product_id"]
    state           = options["lead"]["state"]
    assigned_to_id  = options["lead"]["assigned_to_id"]

    orgs = []
    orgs << Org.find_by_name(org_name) if org_name.not_blank? && org_name.not_eql?("Type to search")
    orgs << Org.find_by_location(org_location) if org_location.not_blank? && org_location.not_eql?("Type to search")
    return [] if orgs.uniq.eql?([nil])

    conditions = []
    conditions << "assigned_to_id = #{assigned_to_id}" unless assigned_to_id.blank?
    conditions << "state = '#{state}'" unless state.blank?
    conditions << orgs.reject{|oo| oo.nil?}.collect{|oo| "org_id = #{oo.id}"}.join(" OR ") unless orgs.empty?
    
    conditions_options = {:conditions => conditions.reject{|con| con.blank?}.collect{|c| "(#{c})"}.join(" AND ")} 
    include_options = {:include => [:org, :author, :assigned_to, :latest_note]}
    options = conditions_options.merge(include_options)

    leads = product_id.blank? ? 
      Lead.find(:all, options) : 
      Lead.find(:all, options) & Project.find(product_id).leads.find(:all, include_options).uniq

    leads.reject{|l| l.not_visible_to?(User.current)}
  end

  def name
    self.org.name
  end

   def pretty_name
     name
   end

  def self.assignable_members
    User.active.find(:all, :include => [:global_role]).select{|m| m.global_role.leads_assignable?}.sort
  end

  def assignable_members
    Lead.assignable_members
  end

  def watching_members
    assignable_members
  end

  def not_visible_to?(user)
    !visible_to?(user)
  end

  def visible_to?(user)
    editable_by?(user) ||
    self.watcher_user_ids.include?(user.id)
  end

  def editable_by?(user)
    user.admin? ||
    self.assigned_to_id == user.id ||
    self.author_id == user.id 
  end

  def not_editable_by?(user)
    !editable_by?(user)
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

end
