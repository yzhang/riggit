module Admin::SitesHelper
  def site_name(site)
    site.nil? ? 'Riggit' : @current_site.name
  end
  
  def site_description(site)
    site.nil? ? 'Description goes here' : @current_site.description
  end
end
