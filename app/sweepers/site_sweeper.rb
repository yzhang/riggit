class SiteSweeper < Sweeper
  observe Site 

  def after_create(site)
    expire_for_site(site)
  end
  
  def after_update(site)
    expire_for_site(site)
  end
  
  def after_destroy(site)
    expire_for_site(site)
  end
  
  private 
  def expire_for_site(site)
    expire_stories_index
    expire_all_stories
    expire_all_channels
    expire_all_categories
  end
end