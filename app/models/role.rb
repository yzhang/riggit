# == Schema Information
# Schema version: 20081201012648
#
# Table name: roles
#
#  id    :integer         not null, primary key
#  title :string(255)
#

class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
end
