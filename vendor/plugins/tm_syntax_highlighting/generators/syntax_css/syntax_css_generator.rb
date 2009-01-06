class SyntaxCssGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      # This whole copy CSS files to the tamplates folder isn't very clean
      # generator library doesn't let me specify an absolute path for m.file so this is a compromise
      # FIXME: make this cleaner
      theme = args[0]

      themes = Uv.themes
      
      if theme == "all"
        m.directory("public/stylesheets/syntax")
        copy_theme_from_uv(*themes)
        themes.each do |css|
          m.file("/#{css}.css", "public/stylesheets/syntax/#{css}.css")
        end
      elsif theme == "list"
        puts themes.sort.join("\n")
      else
        css = themes.detect do |s|
          s.downcase.strip == theme.downcase.strip
        end
        
        if css
          m.directory("public/stylesheets/syntax")
          m.file("#{css}.css", "public/stylesheets/syntax/#{css}.css")
        else
          usage_message
          puts "Could not find theme named #{theme}."
        end
      end
    end
  end
  
  protected
  def banner
    puts "Copies Syntax CSS files to public/stylesheets/syntax/\n\n"
  end  
  
  def usage_message
    puts "Usage: #{$0} syntax_css [all | list | theme_name]"
  end
  
  def copy_theme_from_uv(*args)
    args.each do |theme|
      FileUtils.cp(File.join(Uv.path, "render", "xhtml", "files", "css", "#{theme}.css"), source_path("/"))
    end
  end
end