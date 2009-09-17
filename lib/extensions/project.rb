require_dependency 'project'

module Extensions
  module Project

    def self.included(base)
      base.extend ClassMethods

      base.class_eval do  
        has_many :leads
      end
    end

    module ClassMethods
    end
  end
end

Project.send(:include, Extensions::Project)
