class AddSiteGoogleStuff < ActiveRecord::Migration
  def self.up
    add_column :sites, :google_adsense, :text
    add_column :sites, :google_analytics, :text
    add_column :sites, :show_advertisement, :boolean
    add_column :sites, :admin_email, :string
  end

  def self.down
    remove_column :sites, :google_analytics
    remove_column :sites, :google_adsense
    remove_column :sites, :show_advertisement
    remove_column :sites, :admin_email
  end
end
