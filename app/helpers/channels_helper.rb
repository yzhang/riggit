module ChannelsHelper
  def current_channel_name
    @current_channel.nil? ? '' : @current_channel.name
  end
  
  def link_to_channel(channel)
    content_tag(:li, :class => (channel.name == current_channel_name ? 'selected' : '')) do
      link_to channel.name, channel_path(:channel => channel.name, :page => nil)
    end
  end
  
  def render_channel_menu
    @channels.collect do |channel|
      link_to_channel channel
    end
  end
end
