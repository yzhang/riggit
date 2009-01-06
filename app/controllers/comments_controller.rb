class CommentsController < ApplicationController
  before_filter :login_required

  #cache_sweeper :comment_sweeper, :only => [:create]

  def create
    @comment = current_user.comments.build(params[:comment])
    @partial = @comment.commentable.class == Comment ? 'sub_comment' : 'comment'
    
    respond_to do |format|
      if @comment.save
        @comment.commentable.class.increment_counter(:comment_count, @comment.commentable.id)
        
        format.js do 
          render :update do |page|
            page.replace_html "#{@comment.commentable.div_id}_errors", 'Comment added successful.'
            page.insert_html :bottom, "#{@comment.commentable.div_id}_comments", :partial => @partial, :object => @comment
            page.replace_html "#{@comment.commentable.div_id}_count", @comment.commentable.comments.count
          end
        end
      else
        format.js do
          render :update do |page|
            page.replace_html "#{@comment.commentable.div_id}_errors", :partial => 'comment_error', :locals => {:comment => @comment}
          end
        end
      end
    end
  end
end
