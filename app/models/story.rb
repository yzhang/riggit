# == Schema Information
# Schema version: 20081205064712
#
# Table name: stories
#
#  id                 :integer         not null, primary key
#  category_id        :integer
#  user_id            :integer
#  title              :string(255)
#  url                :string(255)
#  image_url          :string(255)
#  summary            :text
#  digg_count         :integer         default(0)
#  comment_count      :integer         default(0)
#  created_at         :datetime
#  updated_at         :datetime
#  notify_new_comment :boolean
#  youtube_video_id   :string(255)
#

class Story < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :diggs, :as => 'diggable'
  has_many :comments, :as => 'commentable', :dependent => :destroy
  has_and_belongs_to_many :channels, :join_table => 'channels_stories'
  has_many :links
  
  validates_presence_of :title, :category_id, :url, :summary, :user_id
  validates_uniqueness_of :url
  
  acts_as_taggable
  
  named_scope :tagged_with, lambda { |tag| find_options_for_find_tagged_with([tag]).merge(:order => 'stories.created_at DESC') }
  named_scope :in_channel, lambda { |channel| {
    :conditions => ['digg_count >= ?', channel.minimal_diggs],
    :order => "#{channel.sort_by} DESC"
  }}
  
  named_scope :in_moderated_channel, lambda { |channel| {
    :select => 'DISTINCT stories.*',
    :joins => "INNER JOIN channels_stories on channels_stories.channel_id = '#{channel.id}'",
    :conditions => "channels_stories.story_id = #{table_name}.id",
    :order => 'created_at DESC'
  }}
  
  named_scope :in_category, lambda { |category| {
    :conditions => ['category_id = ?', category.id],
    :order => 'created_at DESC'    
  }}
  
  def digg_count
    diggs.count
  end
  
  def comment_count
    comments.count
  end
  
  def div_id
    "story#{self.id}"
  end
end
