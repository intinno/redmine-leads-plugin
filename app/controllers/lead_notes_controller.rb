class LeadNotesController < ApplicationController
  before_filter :find_lead, :only => [:create]


  def create
    @lead_note = LeadNote.new(params[:lead_note])
    @lead_note.author_id = User.current.id

    if @lead_note.save
      @lead.notes << @lead_note
      flash[:notice] = l(:notice_successful_create)
      redirect_to :controller => "leads", :action => "show", :id => @lead.id
    else
      @org = @lead.org 
      render :action => "new"
    end
  end

  def update
    @lead_note = LeadNote.find(params[:id])
    @lead = @lead_note.lead

    if @lead_note.update_attributes(params[:lead_note])
      flash[:notice] = l(:notice_successful_create)
      redirect_to :controller => "leads", :action => "show", :id => @lead.id
    else
      render :action => "edit"
    end
  end

  def edit
    @lead_note = LeadNote.find(params[:id])
    @lead = @lead_note.lead
  end
  
  private
  
  def find_lead
    @lead = Lead.find_by_id(params[:lead_note][:lead_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
