class Admin::SiteLanguagesController < AdminController
  # GET /admin_site_languages
  # GET /admin_site_languages.xml
  def index
    @site_languages = SiteLanguage.find(:all)
    @site_language = SiteLanguage.new
    @languages = Language.find(:all, :conditions => 'iso_639_1 IS NOT NULL')
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /admin_site_languages/1
  # GET /admin_site_languages/1.xml
  def show
    @site_language = SiteLanguage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site_language }
    end
  end

  # GET /admin_site_languages/new
  # GET /admin_site_languages/new.xml
  def new
    @site_language = SiteLanguage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site_language }
    end
  end

  # GET /admin_site_languages/1/edit
  def edit
    @site_language = SiteLanguage.find(params[:id])
  end

  # POST /admin_site_languages
  # POST /admin_site_languages.xml
  def create
    @site_language = SiteLanguage.new(params[:admin_site_language])

    respond_to do |format|
      if @site_language.save
        flash[:notice] = 'SiteLanguage was successfully created.'
        format.html { redirect_to(admin_site_languages_path) }
        format.xml  { render :xml => @site_language, :status => :created, :location => @site_language }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site_language.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_site_languages/1
  # PUT /admin_site_languages/1.xml
  def update
    @site_language = SiteLanguage.find(params[:id])

    respond_to do |format|
      if @site_language.update_attributes(params[:site_language])
        flash[:notice] = 'SiteLanguage was successfully updated.'
        format.html { redirect_to(@site_language) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site_language.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_site_languages/1
  # DELETE /admin_site_languages/1.xml
  def destroy
    @site_language = SiteLanguage.find(params[:id])
    @site_language.destroy

    respond_to do |format|
      format.html { redirect_to(admin_site_languages_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def set_mainmenu
    @mainmenu = 'setting'
  end
end
