class StoryObserver < ActiveRecord::Observer
  def after_create(story)
    @current_site = Site.find(:first)
    Notifier.deliver_story_notification(story, @current_site.admin_email) if !@current_site.admin_email.blank? && @current_site.notify_new_story
  end
end
