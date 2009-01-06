module DiggsHelper
  def digg_link(diggable)
    if logged_in?
      if current_user.digged?(diggable)
        link_to_remote 'Dugg'.t, :url => current_user.digg(diggable), :method => 'delete', :update => "diggable#{diggable.id}", :html => {:class => 'button'}
      else
        link_to_remote 'Digg'.t, :url => diggs_path(:diggable => {
                              :diggable_id => diggable.id, 
                              :diggable_type => diggable.class.to_s }), :method => 'post', :update => "diggable#{diggable.id}", :html => {:class => 'button'}
      end
    else
      link_to 'Digg'.t, new_session_path, :class => 'button'
    end
  end
end
