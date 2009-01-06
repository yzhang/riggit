class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.references :user
      t.string     :nickname
      t.string     :avatar
      t.string     :blog_url
      t.string     :city
      
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
