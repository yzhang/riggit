# == Schema Information
# Schema version: 20081201012648
#
# Table name: links
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  url        :string(255)
#  story_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Link < ActiveRecord::Base
  validates_presence_of :name, :url
  validates_uniqueness_of :url, :scope => [:story_id]
  
  belongs_to :story
  
  def validate
    begin
      uri = URI.parse(url)
      if uri.class != URI::HTTP
        errors.add(:url, 'Only HTTP protocol addresses can be used')
      end
    rescue URI::InvalidURIError
      errors.add(:url, 'The format of the url is not valid.')
    end
  end
end
