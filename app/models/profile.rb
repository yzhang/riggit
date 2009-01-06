# == Schema Information
# Schema version: 20081201012648
#
# Table name: profiles
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  nickname   :string(255)
#  avatar     :string(255)
#  blog_url   :string(255)
#  city       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Profile < ActiveRecord::Base
  belongs_to :user
  
  def avatar_data=(avatar_data)
    unless avatar_data.blank?
      file_dir = "#{RAILS_ROOT}/public/users/#{self.id}"
      Dir.mkdir(file_dir) unless File.directory?(file_dir)
    
      filename = avatar_data.original_filename
      file_path = File.join(file_dir, filename)
      file = File.open(file_path, 'wb') do |f|
        f.write(avatar_data.read)
      end
    
      update_attribute(:avatar, File.join("/users/#{self.id}", filename))
    end
  end
end
