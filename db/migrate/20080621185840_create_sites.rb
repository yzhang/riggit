class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :name
      t.integer :default_channel
      t.string :logo
      t.string :theme

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
