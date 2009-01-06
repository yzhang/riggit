class CommentSweeper < Sweeper
  observe Comment 

  def after_create(comment)
    expire_cache_for(comment)
    expire_story(comment)
  end
  
  def after_update(comment)
    expire_cache_for(comment)
    expire_story(comment)
  end
  
  def after_destroy(comment)
    expire_cache_for(comment)
    expire_story(comment)
  end
  
  def expire_story(comment)
    if comment.commentable.instance_of?(Story)
      expire_page story_path(comment.commentable) 
    elsif comment.commentable.instance_of?(Comment)
      expire_page story_path(comment.commentable.commentable) 
    end
  end
end