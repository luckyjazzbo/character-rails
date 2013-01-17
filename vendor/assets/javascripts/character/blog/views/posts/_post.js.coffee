class Post extends Character.Blog.Views.Base
  tagName: 'li'

  render: ->
    post            = @model.toJSON()
    id              = @model.id
    views           = if post.published then post.views else ''
    draft_or_date   = if post.published then @model.date_formatted() else @model.state()

    category = @model.category()
    category_title = if category then category.get('title') else 'Not set'

    if post.featured_image_id
      img_tag = """<img class='featured' src='#{ @model.thumb_image_url() }' />"""
    else
      img_tag = """<i class='featured no-image general foundicon-photo'></i>"""

    html = """<a href='#/preview/#{id}'>
                #{img_tag}
                <div class='left'>
                  <span class='title'>#{post.title}</span>
                  <span class='meta'>#{category_title}</span>
                </div>
                <div class='right'>
                  <span class='date'>#{draft_or_date}</span>
                  <span class='views'>#{views}</span>
                </div>
              </a>"""
    $(this.el).html html
    return this


Character.Blog.Views.Posts.Post = Post

