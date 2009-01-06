class Admin::CategoriesController < AdminController
  #cache_sweeper :category_sweeper, :only => [:create, :update, :destroy]
    
  def index
    @categories = Category.root.paginate(:page => params[:page], :per_page => 20)
  end
  
  def new
    @category = Category.new
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def create
    @category = Category.new(params[:category])
    
    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_path }
      else
        format.html { render :action => 'new' }
      end
    end
  end
  
  def update
    @category = Category.find(params[:id])
       
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to admin_categories_path }
      else
        format.html { render :action => 'edit' }
      end
    end 
  end
  
  def destroy
    @category = Category.find(params[:id])    
    @category.destroy
    
    respond_to do |format|
      format.js {
        render :update do |page|
          page << "$('#category#{@category.id}').show('highlight');"
          page << "$('#category#{@category.id}').hide('slow');"
        end
      }
    end
  end
  
  private
  def set_mainmenu
    @mainmenu = 'contents'
  end
end
