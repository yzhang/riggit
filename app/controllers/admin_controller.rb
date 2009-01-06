class AdminController < ApplicationController
  before_filter :login_required
  before_filter :set_mainmenu
  
  access_control :DEFAULT => 'admin' 

  layout 'admin'
  
private
  def redirect_to_index(msg)
    flash[:notice] = msg
    redirect_to :action => 'index'
  end
end