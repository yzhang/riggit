class ModeratedStroySweeper < Sweeper
  observe ModeratedStroy 

  def after_create(moderated_stroy)
    expire_for_moderated_stroy
  end
  
  def after_update(moderated_stroy)
    expire_for_moderated_stroy
  end
  
  def after_destroy(moderated_stroy)
    expire_for_moderated_stroy
  end
  
  private
  def expire_for_moderated_stroy
    expire_all_channels
  end
end