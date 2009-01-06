class DiggSweeper < Sweeper
  observe Digg 

  def after_create(digg)
    expire_cache_for(digg)
  end
  
  def after_update(digg)
    expire_cache_for(digg)
  end
  
  def after_destroy(digg)
    expire_cache_for(digg)
  end
end