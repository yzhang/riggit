class CreateChannelsStories < ActiveRecord::Migration
  def self.up
    create_table :channels_stories do |t|
        t.references :channel
        t.references :story
    end
  end

  def self.down
    drop_table :channels_stories
  end
end
