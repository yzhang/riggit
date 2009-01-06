module CommentsHelper
  def comment_form(commentable)
    if logged_in?
      content_tag(:div, :class => "span-2 tags") do
      end +
      content_tag(:div, :class => "span-13 body") do
        content_tag(:div, '', :id => "#{commentable.div_id}_errors") + 
        render(:partial => 'comments/form', :locals => {:commentable => commentable})
      end
    else
      link_to 'Login to comment', new_session_path
    end
  end
  
  def comment_count_tag(commentable)
    content_tag(:span, commentable.comments.count, :id => "#{commentable.div_id}_count")
  end
end
