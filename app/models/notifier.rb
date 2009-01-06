class Notifier < ActionMailer::Base
  default_url_options[:host] = 'www.riggit.org'
  
  def current_theme
    ''
  end
  
  def story_notification(story, email)
    set_site
    recipients email
    from       "info@riggit.org"
    subject    "[#{@current_site.name}]New story added to your site"
    content_type "text/html"
    body[:story] = story
    body[:email] = email
  end
  
  def comment_notification(comment, email)
    set_site
    recipients email
    from       "info@riggit.org"
    subject    "[#{@current_site.name}]New comment added to your post"
    body[:comment] = comment
    body[:email] = email
  end
  
  def user_notification(user, email)
    set_site
    recipients email
    from       "info@riggit.org"
    subject    "[#{@current_site.name}]New story added to your site"
    body[:user] = user
    body[:email] = email
  end
  
  private
  def set_site
    @current_site = Site.find(:first)
  end
end
