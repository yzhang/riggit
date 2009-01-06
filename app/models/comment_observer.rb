class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    @current_site = Site.find(:first)
    deliver_comment_notification(comment, @current_site.admin_email) if !@current_site.admin_email.blank? && @current_site.notify_new_comment
    deliver_comment_notification(comment, comment.user.email) if comment.story.notify_new_comment
  end
end
