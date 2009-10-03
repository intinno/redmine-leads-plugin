class LeadContactsController < ApplicationController
  layout 'crm'
  before_filter :find_lead, :only => [:create]
  before_filter :find_lead_contact, :only => [:show, :edit, :update]
  before_filter :check_permission, :except => [:auto_complete_for_org_name]
  before_filter :reassign_location_name, :only => [:auto_complete_for_location_name, :create, :update]
  before_filter :sanitize_location_params, :only => [:create, :update]
 
  auto_complete_for :location, :name
  auto_complete_for :org, :name
  menu_item :contacts

  def index
    @contacts = []
  end

  def search
    params[:contact] ||= {}    
    if params[:location]
      params[:contact][:city] = params[:location][:name]
    end
    @contacts = LeadContact.search(params[:contact])
    render :partial => "contacts", :layout => false
  end

  def new
    @lead_contact = LeadContact.new
    @contact_org = Org.new
    @bypass_org = true
  end

  def create
    @lead_contact = LeadContact.new(params[:lead_contact])
    @lead_contact.author_id = User.current.id

    if @lead_contact.save
      @lead.contacts << @lead_contact if @lead
      flash[:notice] = l(:notice_successful_create)
      redirect_to lead_or_contact_url 
    else
      make_org
      @org = @lead.org if @lead
      render :action => "new"
    end
  end

  def update
    @lead = @lead_contact.lead
    if @lead_contact.update_attributes(params[:lead_contact])
      flash[:notice] = l(:notice_successful_create)
      redirect_to lead_or_contact_url 
    else
      render :action => "edit"
    end
  end

  def edit
    @lead = @lead_contact.lead
    @org = @lead_contact.org
    @bypass_org = true
  end

  def show
  end
  
  def auto_complete_for_org_name
    find_options = { 
      :conditions => [ "LOWER(name) LIKE ?", '%' + params["org"]["name"].downcase + '%' ], 
      :order => "name ASC",
      :limit => 10 } 
    @items = Org.find(:all, find_options)
    render :partial => "leads/org_name_auto_complete"
  end


  private
  
  def find_lead
    begin 
      @lead = Lead.find_by_id(params[:lead_contact][:lead_id]) if params[:send_to_lead]
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end

  def find_lead_contact 
    @lead_contact = LeadContact.find(params[:id])
  end

  def lead_or_contact_url
    (params[:send_to_lead] ?  
      {:controller => "leads", :action => "show", :id => @lead.id} :
      {:controller => "lead_contacts", :action => "show", :id => @lead_contact.id})
  end
  
  def check_permission
    allowed = true
    if (['new', 'create'].include?(self.action_name))
      allowed = Lead.assignable_members.include?(User.current)
    elsif (['destroy', 'edit', 'update'].include?(self.action_name))
      allowed = @lead_contact.editable_by?(User.current)
    elsif (['show'].include?(self.action_name))
      allowed = @lead_contact.visible_to?(User.current)
    end
    render_404 unless allowed
  end

  def reassign_location_name
    if params[:location][:name_1]
      params[:location][:name] = params[:location][:name_1]
    end
  end

  def make_org
    if params["org_state"].eql?("cancel")
      @bypass_org = true
    else
      if params[:lead_contact][:org_id]
        @contact_org = Org.find(params[:lead_contact][:org_id]) rescue Org.new
      elsif params[:lead_contact][:org_attributes]
        @contact_org = Org.new(params[:lead_contact][:org_attributes])
        @show_org_form = true
      else
        @contact_org = Org.new
      end
    end
  end

  def sanitize_location_params
    if params[:lead_contact][:org_attributes] && params[:org]
      if params[:org][:location] && !params[:org][:location].eql?("Type to search")
        params[:lead_contact][:org_attributes][:location] = params[:org][:location]
      end
    end

    if params[:location][:name] && !params[:location][:name].eql?("Type to search")
      params[:lead_contact][:city] = params[:location][:name]
    end
  end

end
