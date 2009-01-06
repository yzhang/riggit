class Admin::UsersController < AdminController
  
  def index
    @users = User.paginate(:page => params[:page], :per_page => 20)
    @roles = Role.find(:all)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy if @user
    
    respond_to do |format|
      format.html { redirect_to admin_users_path }
    end
  end

  private
  def set_mainmenu
    @mainmenu = 'users'
  end
end
