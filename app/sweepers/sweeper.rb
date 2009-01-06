class Sweeper < ActionController::Caching::Sweeper
  
  protected
  def expire_stories_index
    expire_page(:controller => 'stories', :action => 'index')
  end
  
  def expire_all_channels
    Channel.find(:all).each do |channel|
      expire_page channel_path(channel)
    end
  end
  
  def expire_all_channels
    Tag.find(:all).each do |tag|
      expire_page tag_path(tag)
    end
  end
  
  def expire_all_stories
    Story.find(:all).each do |story|
      expire_page story_path(story)
    end
  end
  
  def expire_story(story)
    expire_story story_path(story)
  end
end