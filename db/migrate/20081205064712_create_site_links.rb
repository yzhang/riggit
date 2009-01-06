class CreateSiteLinks < ActiveRecord::Migration
  def self.up
    create_table :site_links do |t|
      t.string :title
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :site_links
  end
end
