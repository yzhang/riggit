class ChannelSweeper < Sweeper
  observe Channel 

  def after_create(channel)
    expire_cache_for(channel)
  end
  
  def after_update(channel)
    expire_cache_for(channel)
  end
  
  def after_destroy(channel)
    expire_cache_for(channel)
  end
end