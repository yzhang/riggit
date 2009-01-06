module StoriesHelper
  def sanitize_summary(summary)
    #if action_name == 'show'
    white_list(summary.gsub(/<code>([\W\w]*?)<\/code>/) {code($1, :theme => "sunburst", :lang => "ruby", :line_numbers => true)})
    #else
    #  white_list summary.split("\n")[0]
    #end
  end
  
  def link_to_tags(tags)
    tags.collect do |tag|
      content_tag(:span, :class => 'tag') do 
        link_to sanitize(tag), channel_category_tag_path(@current_channel, 'all', tag)
      end unless sanitize(tag).blank?
    end
  end
  
  def link_to_title(story)
    if action_name == 'show'
      link_to h(story.title), story.url
    else
      link_to h(story.title), story
    end
  end
  
  def youtube_thumbnail_tag(story)
    if action_name != 'show'
      link_to image_tag("http://img.youtube.com/vi/#{story.youtube_video_id}/default.jpg", :width => '160'), story
    end
  end
  
  def youtube_video_tag(story)
    return '' unless action_name == 'show'
    
    div_tag = %(
    <div id="videoplayer">
        You need Flash player 8+ and JavaScript enabled to view this video.
    </div>
    )
    div_tag + javascript_tag do
      %(
      var params = { allowScriptAccess: "always" };
      var atts = { id: "riggitplayer" };
      swfobject.embedSWF("http://www.youtube.com/v/#{story.youtube_video_id}", 
                          "videoplayer", "480", "385", "8", null, null, params, atts);
      )
    end
  end
end
