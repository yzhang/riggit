module CategoriesHelper
  def current_category_name
    @current_category.nil? ? '' : @current_category.name
  end
  
  # def category_path(category)
  #   if @current_tag
  #     channel_category_tag_path(:channel => @current_tag.name, :category => category.name, :tag => @current_tag.name, :page => nil) 
  #   else
  #     channel_category_tag_path(:channel => @current_channel.name, :category => category.name, :tag => 'all', :page => nil)
  #   end
  # end
    
  
  def link_to_category(category)
    content_tag(:li, :class => (category.name == current_category_name ? 'selected' : '')) do
      link_to category.name, category_path(:category => category.name)
    end
  end
end
