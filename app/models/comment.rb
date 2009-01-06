# == Schema Information
# Schema version: 20081201012648
#
# Table name: comments
#
#  id               :integer         not null, primary key
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string(255)
#  body             :text
#  comment_count    :integer         default(0)
#  created_at       :datetime
#  updated_at       :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many   :comments, :as => 'commentable', :dependent => :destroy
  
  validates_presence_of :body
  
  named_scope :on_stories, :conditions => {:commentable_type => 'Story'}
  
  def div_id
    "comment#{self.id}"
  end
end
