# Redmine lead plugin
require 'redmine'

require_dependency 'lead_extensions/project'
require_dependency 'lead_extensions/user'
require_dependency 'lead_extensions/active_record'
require_dependency 'lead_extensions/belongs_to_org'

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

  menu :top_menu, :leads, {:controller => 'leads', :action => 'index'}, :caption => "CRM"

Redmine::MenuManager.map :crm_menu do |menu|
  menu.push :leads, {:controller => 'leads', :action => 'index'}, :caption => "Leads"
  menu.push :contacts, {:controller => 'lead_contacts', :action => 'index'}, :caption => "Contacts"
  menu.push :events, {:controller => 'lead_notes', :action => 'index'}, :caption => "Events"
end
end

