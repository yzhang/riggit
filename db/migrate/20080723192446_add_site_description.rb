class AddSiteDescription < ActiveRecord::Migration
  def self.up
    add_column :sites, :description, :string
  end

  def self.down
    remove_column :site, :description
  end
end
