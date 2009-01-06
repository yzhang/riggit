class Admin::ModeratedStoriesController < AdminController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :set_mainmenu
  
  def create
    @moderated_story = ModeratedStory.new(:story_id => params[:story_id], :channel_id => params[:channel_id])
    @moderated_story.save
    
    respond_to do |format|
      format.html { render :inline => "<%= link_to_story_channels(@moderated_story.story) %>"}
    end
  end
end
