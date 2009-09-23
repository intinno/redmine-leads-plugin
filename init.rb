# Redmine lead plugin
require 'redmine'

require_dependency 'lead_extensions/project'
require_dependency 'lead_extensions/user'
require_dependency 'lead_extensions/active_record'

RAILS_DEFAULT_LOGGER.info 'Starting Lead plugin for RedMine'

Redmine::Plugin.register :leads_plugin do
  name 'Leads plugin'
  author 'Udit Sajjanhar'
  description 'This is a plugin for Redmine that can be used to track basic leads(prospective clients) information'
  version '0.1.0'

  url 'http://github.com/intinno/redmine-leads-plugin' if respond_to? :url
  author_url 'http://github.com/intinno/redmine-leads-plugin' if respond_to? :author_url

  
  project_module :lead_module do
    permission :view_lead, {:leads => [:show]}, :public => true
    permission :assign_lead, {:leads => [:assign, :select]}, :public => true
    permission :see_lead_list, {:leads => [:list, :search]}, :public => true
    permission :edit_lead, {:leads => [:edit, :update, :new, :create, :destroy]}, :public => true
  end

  menu :top_menu, :leads, {:controller => 'leads', :action => 'index'}, :caption => "Leads"
end
