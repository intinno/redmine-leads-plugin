class LeadsController < ApplicationController
  unloadable
  layout 'crm'
  before_filter :find_lead, :only => [:show, :edit, :update, :destroy]
  before_filter :check_permission, :except => [:auto_complete_for_org_name]
  before_filter :set_location, :only => [:update, :create]
 
  menu_item :leads, :except => [:new, :create]
  menu_item :new_lead, :only => [:new, :create]

  auto_complete_for :location, :name
  auto_complete_for :org, :name

  def index
    @leads = []
  end

  def search
    @leads = Lead.search(params)
   
    product_id = params[:lead][:product_id]
    @product_name = 
      product_id.blank? ? "" : Project.find(product_id).name 

    render :partial => "leads", :layout => false
  end

  def show
    @org = @lead.org
    @lead_note = LeadNote.new
    @lead_contact = LeadContact.new
  end

    
  def edit
    #@lead = Lead.find_by_id(params[:lead_id])
    @org = @lead.org
  end

  def update
    @lead.watcher_user_ids = params[:lead][:watcher_user_ids]
    if @lead.update_attributes(params[:lead])
      flash[:notice] = l(:notice_successful_update)
      redirect_to :action => "show", :id => @lead.id
    else
      @org = @lead.org
      render :action => "edit", :id => params[:id]
    end
  end

  def destroy
    if @lead.destroy
      flash[:notice] = l(:notice_successful_delete)
    else
      flash[:error] = l(:notice_unsuccessful_save)
    end
    redirect_to :action => "search"
  end
  
  def new
    @lead = Lead.new
    @org = Org.new
  end

  def create
    @lead = Lead.new(params[:lead])
    @lead.author_id = User.current.id
    @lead.watcher_user_ids = params[:lead][:watcher_user_ids]
    if @lead.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to :action => "show", :id => @lead.id
    else
      make_org
      render :action => "new"
    end
  end
  
  def auto_complete_for_org_name
    find_options = { 
      :conditions => [ "LOWER(name) LIKE ?", '%' + params["org"]["name"].downcase + '%' ], 
      :order => "name ASC",
      :limit => 10 } 
    @items = Org.find(:all, find_options)
    render :partial => "org_name_auto_complete"
  end

  private
  
  def find_lead
    @lead = Lead.find_by_id(params[:id])
    render_404 if @lead.not_visible_to?(User.current)
  rescue ActiveRecord::RecordNotFound
    render_404
  end
  
  def find_leads
    @leads = Lead.find(:all) || []
  end

  def check_permission
    allowed = true
    if (['new', 'create'].include?(self.action_name))
      allowed = Lead.assignable_members.include?(User.current)
    elsif (['destroy', 'edit', 'update'].include?(self.action_name))
      allowed = @lead.editable_by?(User.current)
    elsif (['show'].include?(self.action_name))
      allowed = @lead.visible_to?(User.current)
    end
    render_404 unless allowed
  end
  
  def make_org
    if params[:lead][:org_id]
      @org = Org.find(params[:lead][:org_id]) rescue Org.new
    elsif params[:lead][:org_attributes]
      @org = Org.new(params[:lead][:org_attributes])
      @show_org_form = true
    else
      @org = Org.new
    end
  end

  def set_location
    if params[:lead][:org_attributes] && params[:org]
      if params[:org][:location] && !params[:org][:location].eql?("Type to search")
        params[:lead][:org_attributes][:location] = params[:org][:location]
      end
    end
  end
end
