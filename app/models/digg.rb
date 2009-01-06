# == Schema Information
# Schema version: 20081201012648
#
# Table name: diggs
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  diggable_id   :integer
#  diggable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Digg < ActiveRecord::Base
  belongs_to :user
  belongs_to :diggable, :polymorphic => true 
  
  validates_uniqueness_of :user_id, :scope => [:diggable_id, :diggable_type]
end
