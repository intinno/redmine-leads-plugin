module LeadExtensions
  module BelongsToOrg

    def self.included(base)
      base.class_eval do  
        include InstanceMethods
        extend ClassMethods
      end
    end

    module InstanceMethods
      def org_attributes=(attrs)
        return unless attrs["name"]
        self.new_record? || self.org.nil? ?
          self.build_or_create_association("org", attrs) :
          self.org.update_attributes(attrs)
      end

      def orgname
        self.org.name rescue nil
      end
    end

    module ClassMethods
      def belongs_to_org
        belongs_to :org
        attr_accessor :org_name
        validates_associated :org, :message => "Organization Details are invalid"
      end
    end
  end
end

ActiveRecord::Base.send(:include, LeadExtensions::BelongsToOrg)
