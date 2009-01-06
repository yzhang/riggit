# Extending <tt>ActionView::Base</tt> to support rendering themes
#
module ActionView
   # <tt>ThemeError</tt> is thrown when <tt>force_liquid</tt> is true, and 
   # a <tt>.liquid</tt> template isn't found.
   class ThemeError < StandardError
   end
   
   # Extending <tt>ActionView::Base</tt> to support rendering themes
   class Base
     alias_method :__render_partial, :render_partial
      
      def render_partial(partial_path, object_assigns = nil, local_assigns = {})
        @finder.prepend_view_path("#{RAILS_ROOT}/themes/#{controller.current_theme}/views")
        @finder.prepend_view_path("#{RAILS_ROOT}/themes/#{controller.current_theme}")
        __render_partial(partial_path, object_assigns, local_assigns)
      end
      
      alias_method :__render_file, :render_file
      
      # Overrides the default <tt>Base#render_file</tt> to allow theme-specific views
      def render_file(template_path, use_full_path = true, local_assigns = {})
        @finder.prepend_view_path("#{RAILS_ROOT}/themes/#{controller.current_theme}/views")
        @finder.prepend_view_path("#{RAILS_ROOT}/themes/#{controller.current_theme}")
        __render_file(template_path, use_full_path, local_assigns)                    
      end
   end
end
