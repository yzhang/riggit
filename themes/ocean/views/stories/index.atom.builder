atom_feed do |feed|
  feed.title("#{@feed_title}")
  feed.updated((@stories.first.created_at))

  for story in @stories
    feed.entry(story) do |entry|
      entry.title(story.title)
      entry.content(story.summary, :type => 'text')
      entry.author do |author|
        author.name(story.user.login)
      end
    end
  end
end