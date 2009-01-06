class Admin::StoriesController < AdminController
  
  def index
    @stories = Story.paginate(:page => params[:page], :per_page => 20, :order => 'updated_at DESC')
  end
  
  def edit
    @story = Story.find(params[:id])
  end
  
  def update
    @story = Story.find(params[:id])
    @story.links.delete_all
    
    params[:links].each do |name, url|
      @story.links.create(:name => name, :url => url)
    end if params[:links]
    
    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to admin_stories_path }
      else
        format.html { render :action => 'edit' }
      end
    end
  end
  
  def destroy
    @story = Story.find(params[:id])    
    @story.destroy
    
    respond_to do |format|
      format.js {
        render :update do |page|
          page << "$('#story#{@story.id}').show('highlight');"
          page << "$('#story#{@story.id}').hide('slow');"
        end
      }
    end
  end
  
  private
  def set_mainmenu
    @mainmenu = 'contents'
  end
end
