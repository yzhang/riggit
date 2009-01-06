# == Schema Information
# Schema version: 20081201012648
#
# Table name: admin_site_languages
#
#  id          :integer         not null, primary key
#  language_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class SiteLanguage < ActiveRecord::Base
  set_table_name 'admin_site_languages'
  validates_presence_of :language_id
  validates_uniqueness_of :language_id
  
  belongs_to :language
end
