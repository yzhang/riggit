class Admin::TranslationsController < AdminController
  before_filter :set_languages
  def index
    @languages = SiteLanguage.find(:all).map(&:language)

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def translated
    @translations = Translation.paginate(:page => params[:page], :per_page => 100,
                 :conditions => ['text IS NOT NULL AND language_id = ?', @language.id],
                 :order => 'tr_key ASC')
   
    respond_to do |format|
      format.html 
    end
  end
  
  def untranslated
    @translations = Translation.paginate(:page => params[:page], :per_page => 100, 
                 :conditions => ['language_id = ? and text IS NULL', @language.id], 
                 :order => 'tr_key ASC')
   
    respond_to do |format|
      format.html 
    end
  end
  
  # GET /globalize_translations/1/edit
  def edit
    @translation = Translation.find(params[:id])
  end

  def update
    @translation = Locale.set_translation(params[:tr_key], @language, params[:text])
    Translation.delete_all(['tr_key = ? and text IS NULL', params[:tr_key]])
        
    respond_to do |format|
      if @translation
        flash[:notice] = 'Translation was successfully created'
        format.html { redirect_to(untranslated_admin_translations_path(:language_id => params[:language_id])) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /globalize_translations/1
  # DELETE /globalize_translations/1.xml
  def destroy
    @translation = Translation.find(params[:id])
    @translation.destroy

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
  
  private
  def set_mainmenu
    @mainmenu = 'setting'
  end
  
  def set_languages
    @language = Language.find_by_iso_639_1(params[:language_id] || 'en')
    @languages = SiteLanguage.find(:all).map(&:language)    
  end
end
