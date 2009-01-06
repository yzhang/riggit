class Admin::ChannelsController < AdminController
  skip_before_filter :set_site, :only => [:new, :create]
   
  #cache_sweeper :channel_sweeper, :only => [:create, :update, :destroy]
  
  def index
    @channels = Channel.paginate(:page => params[:page], :per_page => 20)
  end
  
  def new
    @channel = Channel.new
  end
  
  def edit
    @channel = Channel.find(params[:id])
  end
  
  def create
    @channel = Channel.new(params[:channel])
    
    respond_to do |format|
      if @channel.save
        format.html { redirect_to admin_channels_path }
      else
        format.html { render :action => 'new' }
      end
    end
  end
  
  def update
    @channel = Channel.find(params[:id])
       
    respond_to do |format|
      if @channel.update_attributes(params[:channel])
        format.html { redirect_to admin_channels_path }
      else
        format.html { render :action => 'edit' }
      end
    end 
  end
  
  def destroy
    @channel = Channel.find(params[:id])    
    @channel.destroy
    
    respond_to do |format|
      format.js {
        render :update do |page|
          page << "$('#channel#{@channel.id}').show('highlight');"
          page << "$('#channel#{@channel.id}').hide('slow');"
        end
      }
    end
  end

  private
  def set_mainmenu
    @mainmenu = 'contents'
  end 
end
