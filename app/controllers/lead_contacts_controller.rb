class LeadContactsController < ApplicationController
  layout 'crm'
  before_filter :find_lead, :only => [:create]
  before_filter :find_lead_contact, :only => [:show, :edit, :update]
  before_filter :check_permission
  auto_complete_for :location, :name
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
  end

  def create
    params[:lead_contact][:city] = params[:location][:name]
    @lead_contact = LeadContact.new(params[:lead_contact])
    @lead_contact.author_id = User.current.id

    if @lead_contact.save
      @lead.contacts << @lead_contact if @lead
      flash[:notice] = l(:notice_successful_create)
      redirect_to lead_or_contact_url 
    else
      @org = @lead.org if @lead 
      render :action => "new"
    end
  end

  def update
    params[:lead_contact][:city] = params[:location][:name]
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
  end

  def show
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

end
