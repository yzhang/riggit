# == Schema Information
# Schema version: 20081201012648
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  validates_presence_of :name
  
  belongs_to :parent, :class_name => 'Category'
  has_many   :children, :class_name => 'Category', :foreign_key => 'parent_id', :dependent => :destroy
  
  named_scope :root, :conditions => 'parent_id is NULL'

  def to_s
    name
  end
end
