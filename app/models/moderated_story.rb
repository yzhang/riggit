# == Schema Information
# Schema version: 20081201012648
#
# Table name: channels_stories
#
#  id         :integer         not null, primary key
#  channel_id :integer
#  story_id   :integer
#

class ModeratedStory < ActiveRecord::Base
  set_table_name 'channels_stories'
  
  validates_presence_of :story_id, :channel_id
  validates_uniqueness_of :story_id, :scope => [:channel_id]
  
  belongs_to :channel
  belongs_to :story
end
