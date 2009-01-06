module AdminHelper

  def contents_path
    admin_stories_path
  end
  
  def contents_submenu_tag
    content_tag(:ul) do
      ['Stories', 'Comments', 'Channels', 'Categories'].collect do |item|
        content_tag(:li, :class => (item.downcase == controller.controller_name ? 'selected' : '')) do
          link_to item.t, eval("admin_#{item.downcase}_path")
        end
      end.join('')
    end
  end
  
  def design_path
    ''
  end
  
  def setting_path
    edit_admin_site_path(@current_site)
  end
  
  def admin_translated_strings_path
    translated_admin_translations_path
  end
  
  def admin_untranslated_strings_path
    untranslated_admin_translations_path
  end  
  
  def admin_languages_path
    admin_site_languages_path
  end  
  
  def setting_submenu_tag
    content_tag(:ul) do
      ['Sites', 'Translations', 'Languages', 'Site_Links'].collect do |item|
        content_tag(:li, :class => (item.downcase == controller.controller_name ? 'selected' : '')) do
          link_to item.t, eval("admin_#{item.downcase}_path")
        end
      end.join('')
    end
  end
  
  def users_path
    admin_users_path
  end
  
  def users_submenu_tag
    content_tag(:ul) do
      ['Users'].collect do |item|
        content_tag(:li, :class => (item.downcase == controller.controller_name ? 'selected' : '')) do
          link_to item.t, eval("admin_#{item.downcase}_path")
        end
      end.join('')
    end
  end
  
  def admin_mainmenu_tag
    content_tag(:ul) do
      ['Contents', 'Users', 'Design', 'Setting'].collect do |item|
        content_tag(:li, :class => (item.downcase == @mainmenu ? 'selected' : '')) do
          link_to item.t, eval("#{item.downcase}_path")
        end
      end.join('')
    end
  end
end