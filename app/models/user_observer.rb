class UserObserver < ActiveRecord::Observer
  def after_create(user)
    @current_site = Site.find(:first)
    deliver_useer_notification(user, @current_site.admin_email) if !@current_site.admin_email.blank? && @current_site.notify_new_user
  end
end
