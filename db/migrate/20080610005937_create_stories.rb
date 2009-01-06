class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.references :category
      t.references :user
      
      t.string     :title
      t.string     :url
      t.string     :image_url
      t.text       :summary
      
      t.integer    :digg_count, :default => 0
      t.integer    :comment_count, :default => 0
      
      t.timestamps
    end
    
  end

  def self.down
    drop_table :stories
  end
end
