class AddSiteShowDescription < ActiveRecord::Migration
  def self.up
    add_column :sites, :show_description, :boolean
  end

  def self.down
    remove_column :sites, :show_description
  end
end
