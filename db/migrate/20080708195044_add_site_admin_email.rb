class AddSiteAdminEmail < ActiveRecord::Migration
  def self.up
    add_column :sites, :notify_new_story, :boolean, :default => true
    add_column :sites, :notify_new_comment, :boolean, :default => false
    add_column :sites, :notify_new_user, :boolean, :default => false
    add_column :stories, :notify_new_comment, :boolean
    add_column :sites, :url, :string
  end

  def self.down
    remove_column :sites, :notify_new_story
    remove_column :sites, :notify_new_comment
    remove_column :sites, :notify_new_user
    remove_column :stories, :notify_new_comment
    remove_column :sites, :url
  end
end
