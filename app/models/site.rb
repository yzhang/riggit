# == Schema Information
# Schema version: 20081201012648
#
# Table name: sites
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  default_channel    :integer
#  logo               :string(255)
#  theme              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  google_analytics   :text
#  google_adsense     :text
#  show_advertisement :boolean
#  admin_email        :string(255)
#  notify_new_story   :boolean         default(TRUE)
#  notify_new_comment :boolean
#  notify_new_user    :boolean
#  url                :string(255)
#  description        :string(255)
#  show_description   :boolean
#

class Site < ActiveRecord::Base
  validates_presence_of :name, :default_channel
  
  belongs_to :home_channel, :class_name => 'Channel', :foreign_key => 'default_channel'
  
  before_create :set_theme
  
  def logo_data=(logo_data)
    unless logo_data.blank?
      file_dir = "#{RAILS_ROOT}/public/site/"
      Dir.mkdir(file_dir) unless File.directory?(file_dir)
    
      filename = logo_data.original_filename
      file_path = File.join(file_dir, filename)
      file = File.open(file_path, 'wb') do |f|
        f.write(logo_data.read)
      end
    
      update_attribute(:logo, File.join("/site", filename))
    end
  end
  
  private
  def set_theme
    self.theme = Theme.find_all.first.name
  end
end
