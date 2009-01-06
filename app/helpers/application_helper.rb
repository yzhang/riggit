# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
  
  def link_to_tag(tag, options = {})
    link_to h(tag.name), tag_path(:tag => tag.name, :page => nil), options
  end
  
  def languages_tag
    ['us', 'zh'].collect do |language|
      content_tag(:li) do
        link_to image_tag("/images/flags/#{language}.png"), select_language_session_path(:language => language), :method => 'put'
      end
    end.join('')
  end
  
  def remove_image_tag
    image_tag(image_path('ico/remove.png'))
  end
  
  def edit_image_tag
    image_tag(image_path('ico/edit.png'))
  end  
  
  def link_to_remove(obj, params={})
    url = eval("admin_#{obj.class.to_s.underscore}_path(obj)")
    if params[:update]
      link_to_remote(remove_image_tag, :url => url,
                      :update => params[:update], :method => 'delete')
    else
      link_to remove_image_tag, url, :confirm => "Are you sure you want to delete this #{obj.class.to_s.humanize}?", :method => 'delete'
    end
  end
  
  def link_to_edit(obj)
    url = eval("edit_admin_#{obj.class.to_s.underscore}_path(obj)")
    link_to edit_image_tag, url
  end
end
