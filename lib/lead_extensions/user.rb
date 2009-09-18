require_dependency 'user'

module LeadExtensions
  module User

    def self.included(base)
      base.extend ClassMethods

      base.class_eval do  
        #associations
        belongs_to :global_role, :class_name => "Role"

        #scope
        named_scope :active, :conditions => {:status => 1}
      end
    end

    module ClassMethods
    end
  end
end

User.send(:include, LeadExtensions::User)
