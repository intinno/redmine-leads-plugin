class OrgsController < ApplicationController
  def index
    @orgs = Org.all
  end
  
  def show
    @org = Org.find(params[:id])
  end
  
  def new
    @org = Org.new
  end
  
  def create
    @org = Org.new(params[:org])
    if @org.save
      flash[:notice] = "Successfully created org."
      redirect_to @org
    else
      render :action => 'new'
    end
  end
  
  def edit
    @org = Org.find(params[:id])
  end
  
  def update
    @org = Org.find(params[:id])
    if @org.update_attributes(params[:org])
      flash[:notice] = "Successfully updated org."
      redirect_to @org
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @org = Org.find(params[:id])
    @org.destroy
    flash[:notice] = "Successfully destroyed org."
    redirect_to orgs_url
  end
end
