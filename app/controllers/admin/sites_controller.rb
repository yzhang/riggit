class Admin::SitesController < AdminController
  skip_before_filter :set_site, :only => [:new, :create]
  
  def index
  end
  
  def new
    @channels = Channel.find(:all)
    @site = Site.new
    
    respond_to do |format|
      if Site.count != 0
        format.html { redirect_to admin_sites_path }
      else
        format.html
      end
    end
  end
  
  def edit
    @site = @current_site
  end
  
  def create
    @site = Site.new(params[:site])
    
    respond_to do |format|
      if Site.count != 0
        format.html { redirect_to admin_sites_path }
      else
        if @site.save
          format.html { redirect_to admin_sites_path }
        else
          format.html { render :action => 'new' }
        end
      end
    end
  end
  
  def update
    @site = @current_site
    
    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to admin_sites_path }
      else
        format.html { render :action => 'edit' }
      end
    end
  end
  
  private
  def set_mainmenu
    @mainmenu = 'setting'
  end
end
