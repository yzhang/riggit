class AddStoryVideoUrl < ActiveRecord::Migration
  def self.up
    add_column :stories, :youtube_video_id, :string
  end

  def self.down
    remove_column :stories, :youtube_video_id
  end
end
