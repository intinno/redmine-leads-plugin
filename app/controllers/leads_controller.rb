class LeadsController < ApplicationController
  unloadable
  layout 'base'
  before_filter :find_lead, :only => [:show, :edit, :update, :destroy]
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
    @lead.author_id = @current_user.id
    @lead.watcher_user_ids = params[:lead][:watcher_user_ids]
    if @lead.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to :action => "show", :id => @lead.id
    else
      @org = Org.new(params[:lead][:org_attributes])
      render :action => "new"
    end
  end
  
  private
  
  def find_lead
    @lead = Lead.find_by_id(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
  
  def find_leads
    @leads = Lead.find(:all) || []
  end

end
