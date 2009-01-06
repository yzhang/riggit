class StorySweeper < Sweeper
  observe Story 

  def after_create(stroy)
    expire_stories
  end
  
  def after_update(stroy)
    expire_stories
  end
  
  def after_destroy(stroy)
    expire_stories
  end
  
  def expire_stories
    expire_stories_index
    expire_all_channels
    expire_all_tags
  end
end