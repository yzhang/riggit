require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SiteLink do
  before(:each) do
    @site_link = SiteLink.new
  end

  it "should be valid" do
    @site_link.should be_valid
  end
end
