class CreateAdminSiteLanguages < ActiveRecord::Migration
  def self.up
    create_table :admin_site_languages do |t|
      t.integer :language_id

      t.timestamps
    end
    
    SiteLanguage.load_from_file
    Translation.load_from_file
  end

  def self.down
    drop_table :admin_site_languages
  end
end
