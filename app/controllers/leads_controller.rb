class LeadsController < ApplicationController
  unloadable
  layout 'base'
  before_filter :find_project, :authorize
  before_filter :find_lead, :only => [:edit, :update, :destroy]
  before_filter :find_lead, :only => [:list, :select]
 
  def show
    @leads = @project.leads
  end
  
  def list
    #@leads = Lead.find(:all)
  end

  def select
    #@leads = Lead.find(:all)
  end
  
  def assign
    @lead = Lead.find(params[:lead][:id])
    @lead.project_id = @project.id 
    if @lead.save
      flash[:notice] = l(:notice_successful_save)
      redirect_to :action => "show", :id => params[:id]
    else
      flash[:notice] = l(:notice_unsuccessful_save)
      redirect_to :action => "select", :id => params[:id]
    end
  end
    
  def edit
    #@lead = Lead.find_by_id(params[:lead_id])
  end

  def update
    #@lead = Lead.find_by_id(params[:lead_id])
    if @lead.update_attributes(params[:lead])
      flash[:notice] = l(:notice_successful_update)
      redirect_to :action => "list", :id => params[:id]
    else
      render :action => "edit", :id => params[:id]
    end
  end

  def destroy
    #@lead = Lead.find_by_id(params[:lead_id])
    if @lead.destroy
      flash[:notice] = l(:notice_successful_delete)
    else
      flash[:error] = l(:notice_unsuccessful_save)
    end
    redirect_to :action => "list", :id => params[:id]
  end
  
  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(params[:lead])
    if @lead.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to :action => "select", :id => params[:id]
    else
      render :action => "new", :id => params[:id]
    end
  end
  
  private
  
  def find_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_lead
    @lead = Lead.find_by_id(params[:lead_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
  
  def find_leads
    @leads = Lead.find(:all) || []
  end

end
