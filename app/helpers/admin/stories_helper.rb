module Admin::StoriesHelper
  def link_to_story_channels(story)
    story.channels.collect do |channel|
      link_to channel.name, channel
    end.join(' ')
  end
end
