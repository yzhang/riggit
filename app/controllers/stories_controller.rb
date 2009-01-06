class StoriesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :get_categories
  layout 'application'
  
#  caches_page :show, :index
#  caches_action :new
#  cache_sweeper :story_sweeper, :only => [:create]
  
  def index
    @stories = @current_tag ? Story.tagged_with(@current_tag.name) : @current_channel.stories
    @stories = @stories.in_category(@current_category) if @current_category
    @stories = @stories.paginate(:page => params[:page], :per_page => 20)

    @feed_title = @current_category ? "All #{@current_category.name} Stories " : "All Stories "
    @feed_title += @current_tag ? "Tagged with #{@current_tag.name}" : "in #{@current_channel.name} Channel"

    @site_description += ',' + @stories.map(&:title).join(',')
    
    respond_to do |format|
      format.html
      format.atom do 
        render :layout => false
      end
    end
  end
  
  def show
    @story = Story.find(params[:id])
    @comment = Comment.new
    @comment.commentable = @story
    @comments = @story.comments.paginate(:page => params[:page], :per_page => 20) if @story
    @site_title = @current_site.name + ' &raquo; ' + @story.title
    
    # add story title and content to meta.
    @site_description = @story.title + ' - ' + @story.summary
  end
  
  def new
    @story = Story.new
  end
  
  def create 
    @story = current_user.stories.build(params[:story])
    
    params[:links].each do |name, url|
      @story.links.build(:name => name, :url => url)
    end if params[:links]
    
    respond_to do |format|
      if @story.save
        flash[:notice] = 'Story has been successful submited.'
        format.html { redirect_to root_path }
      else
        format.html { render :action => 'new' }
      end
    end
  end
  
  protected
    def get_categories
      @categories = Category.root
    end
end
