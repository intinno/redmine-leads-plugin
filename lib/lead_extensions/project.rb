require_dependency 'project'

module LeadExtensions
  module Project

    def self.included(base)
      base.extend ClassMethods

      base.class_eval do  
        #associations
        has_many :leads_projects, :dependent => :destroy
        has_many :leads, :through => :leads_projects

        #scopes
        named_scope :products, :conditions => {:is_product => 1}
      end
    end

    module ClassMethods
    end
  end
end

Project.send(:include, LeadExtensions::Project)
