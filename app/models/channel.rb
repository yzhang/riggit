# == Schema Information
# Schema version: 20081201012648
#
# Table name: channels
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  sort_by       :string(255)
#  minimal_diggs :integer
#  weight        :integer
#  need_moderate :boolean
#  created_at    :datetime
#  updated_at    :datetime
#

class Channel < ActiveRecord::Base
  validates_presence_of :name, :minimal_diggs, :sort_by, :weight
  
  has_and_belongs_to_many :moderated_stories, :class_name => 'Story', :join_table => 'channels_stories'
  
  def stories
    self.need_moderate ? Story.in_moderated_channel(self) : Story.in_channel(self)
  end
end
