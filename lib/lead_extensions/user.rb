require_dependency 'user'

module LeadExtensions
  module User

    def self.included(base)
      base.extend ClassMethods

      base.class_eval do  
        #associations
        belongs_to :global_role, :class_name => "Role"
        has_many :assigned_leads, :class_name => "Lead", :foreign_key => "assigned_to_id"
        has_many :lead_contacts, :through => :assigned_leads, :source => :contacts

        #scope
        named_scope :active, :conditions => {:status => 1}
      end
    end

    module ClassMethods
    end
  end
end

User.send(:include, LeadExtensions::User)
