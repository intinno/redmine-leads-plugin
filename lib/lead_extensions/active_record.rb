module LeadExtensions
  module ActiveRecord

    def self.included(base)
      base.class_eval do  
        include InstanceMethods
      end
    end

    module InstanceMethods
      def build_or_create_association(name, attributes)
        begin 
          self.new_record? ?
            self.send("build_#{name}", attributes) :
            self.send("create_#{name}", attributes)
        rescue
          self.new_record? ?
            self.send("#{name}").send("build", attributes) :
            self.send("#{name}").send("create!", attributes)
        end
      end

      def create_or_update_association(name, attributes)
        self.send("#{name}").nil? ?
          build_or_create_association(name, attributes) :
          self.send("#{name}").send("update_attributes", attributes)
      end
    end
  end
end

ActiveRecord::Base.send(:include, LeadExtensions::ActiveRecord)
