xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title ENV['WEBSITE_NAME']
    xml.description ENV['WEBSITE_DESCRIPTION']
    xml.link 'http://' + ENV['WEBSITE_URL'] + blog_index_path

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.excerpt
        xml.pubDate post.date.to_s(:rfc822)
        xml.link 'http://' + ENV['WEBSITE_URL'] + blog_post_path(post.slug)
        xml.guid 'http://' + ENV['WEBSITE_URL'] + blog_post_path(post.slug)
      end
    end
  end
end