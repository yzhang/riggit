module Admin::CommentsHelper
  def link_to_comment(comment)
    if comment.comments.count.zero?
      comment.body
    else
      link_to comment.body, '#', :onclick => "$('#sub_comments#{comment.id}').toggle(); return false;"
    end
  end
end
