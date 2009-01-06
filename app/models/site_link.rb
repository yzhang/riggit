# == Schema Information
# Schema version: 20081205064712
#
# Table name: site_links
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class SiteLink < ActiveRecord::Base
end
