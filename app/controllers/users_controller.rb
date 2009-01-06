class UsersController < ApplicationController
  layout 'application'
  before_filter :login_required, :only => [:edit]

  #caches_page :new, :show
  #caches_action :edit

  # render new.rhtml
  def new
    @user = User.new
    @user.profile = Profile.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = current_user
  end
 
  def update
    @user = current_user
    @user.profile.update_attributes(params[:profile])
    redirect_to edit_user_path(@user)
  end
  
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.profile = Profile.new(params[:profile])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      #self.current_user = @user # !! now logged in
      redirect_to new_session_path
      flash[:notice] = "Thanks for signing up!".t
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin.".t
      render :action => 'new'
    end
  end
end
