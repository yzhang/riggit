class DiggsController < ApplicationController
  before_filter :login_required
  
  # cache_sweeper :digg_sweeper
  
  def create
    @digg = current_user.diggs.new(params[:diggable])
    @digg.diggable.class.increment_counter(:digg_count, @digg.diggable.id) if @digg.save
    
    respond_to do |format|
      format.html {render :partial => 'digg_link', :locals => {:diggable => @digg.diggable}}
    end
  end
  
  def destroy
    @digg = current_user.diggs.find(params[:id])
    @digg.destroy if @digg
    @digg.diggable.class.decrement_counter(:digg_count, @digg.diggable.id)    
    
    respond_to do |format|
      format.html {render :partial => 'digg_link', :locals => {:diggable => @digg.diggable}}
    end
  end
end
