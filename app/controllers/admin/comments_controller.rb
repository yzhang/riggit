class Admin::CommentsController < AdminController
  def index
    @comments = Comment.on_stories.paginate(:page => params[:page], :per_page => 20)
  end
  
  def destroy
    @comment = Comment.find(params[:id])    
    @comment.destroy
    @comment.commentable.class.decrement_counter(:comment_count, @comment.commentable.id)

    respond_to do |format|
      format.js {
        render :update do |page|
          page << "$('#comment#{@comment.id}').show('highlight');"
          page << "$('#comment#{@comment.id}').hide('slow');"
        end
      }
    end
  end
  
  private
  def set_mainmenu
    @mainmenu = 'contents'
  end
end
