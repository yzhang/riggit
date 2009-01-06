# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  include AuthenticatedSystem
  include ExceptionNotifiable
  
  theme :site_theme
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'fd804ab914a1bce2cd71297fe09703f8'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  before_filter :set_site
  before_filter :set_language
  
  def rescue_404
    render :template => "#{RAILS_ROOT}/themes/#{@current_site.theme}/404.html", :layout => 'application'
  end
  
  def rescue_500
    render :template => "#{RAILS_ROOT}/themes/#{@current_site.theme}/500.html", :layout => 'application'
  end
  
  private
  def set_language
    default_locale = 'en'
    request_language = request.env['HTTP_ACCEPT_LANGUAGE']
    request_language = request_language.nil? ? nil : request_language[/[^,;]+/]
    preferred_language = nil #logged_in? ? (current_user.display_language ? current_user.display_language.globalize_language.iso_639_1 : nil) : nil

    @request_language = preferred_language || session[:language] || request_language || default_locale
      
    # re-write language to session if session[:language] is empty
    session[:language] ||= @request_language

    begin
      Globalize::Locale.set @request_language
    rescue
      Globalize::Locale.set default_locale
    end
  end
  
  def site_theme
    @current_site.nil? ? Theme.find_all.first.name : @current_site.theme
  end
  
  def set_site
    @current_site = Site.find(:first)
    @channels = Channel.find(:all, :order => 'weight')
    @categories = Category.find(:all)

    unless @current_site 
      flash[:error] = "Please set up your site at first."
      return redirect_to(new_admin_site_path)
    end
    
    set_site_title
    set_current_channel
    set_current_category
    set_current_tag
  end
  
  def set_site_title
    if @current_site.description.blank?
      @site_title = @current_site.name
      @site_description = @current_site.name
    else
      @site_title = @current_site.name + ' - ' + @current_site.description
      @site_description = @current_site.description
    end
  end
  
  def set_current_tag
    @tags = Story.tag_counts
    @current_tag = Tag.find_by_name(params[:tag])    if params[:tag].instance_of?(String)
    @site_title = @current_site.name + ' &raquo; ' + @current_tag.name if @current_tag.is_a?(Tag)
  end

  def set_current_channel
    session[:channel] = Channel.find_by_name(params[:channel]) if params[:channel] && params[:channel].instance_of?(String)
    @site_title = @current_site.name + ' &raquo; ' + session[:channel].name if session[:channel] && session[:channel].id != @current_site.home_channel.id
    @current_channel = session[:channel] || @current_site.home_channel
  end
  
  def set_current_category
    @current_category = Category.find_by_name(params[:category]) if params[:category] && params[:category].instance_of?(String)
    @site_title = @current_site.name + ' &raquo; ' + @current_category.name if @current_category.is_a?(Category)
  end
end
