class Admin::SiteLinksController < AdminController
  # GET /admin_site_links
  # GET /admin_site_links.xml
  def index
    @site_links = SiteLink.find(:all)
    @site_link = SiteLink.new
    @languages = Language.find(:all, :conditions => 'iso_639_1 IS NOT NULL')
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /admin_site_links/1
  # GET /admin_site_links/1.xml
  def show
    @site_link = SiteLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site_link }
    end
  end

  # GET /admin_site_links/new
  # GET /admin_site_links/new.xml
  def new
    @site_link = SiteLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site_link }
    end
  end

  # GET /admin_site_links/1/edit
  def edit
    @site_link = SiteLink.find(params[:id])
  end

  # POST /admin_site_links
  # POST /admin_site_links.xml
  def create
    @site_link = SiteLink.new(params[:site_link])

    respond_to do |format|
      if @site_link.save
        flash[:notice] = 'SiteLink was successfully created.'
        format.html { redirect_to(admin_site_links_path) }
        format.xml  { render :xml => @site_link, :status => :created, :location => @site_link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site_link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_site_links/1
  # PUT /admin_site_links/1.xml
  def update
    @site_link = SiteLink.find(params[:id])

    respond_to do |format|
      if @site_link.update_attributes(params[:site_link])
        flash[:notice] = 'SiteLink was successfully updated.'
        format.html { redirect_to(@site_link) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site_link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_site_links/1
  # DELETE /admin_site_links/1.xml
  def destroy
    @site_link = SiteLink.find(params[:id])
    @site_link.destroy

    respond_to do |format|
      format.html { redirect_to(admin_site_links_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def set_mainmenu
    @mainmenu = 'setting'
  end
end
