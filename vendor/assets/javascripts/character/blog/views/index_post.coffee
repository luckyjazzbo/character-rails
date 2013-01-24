class BlogIndexPost extends Backbone.View
  tagName: 'li'

  render: ->
    id    = @model.id
    title = @model.get('title')
    
    # refactor this!
    draft_or_date   = if @model.get('published') then @model.date_formatted() else @model.state()
    
    # refactor this!
    category_title = ''
    if blog.options.categories
      category = @model.category()
      category_title = if category then category.get('title') else 'Not set'

    img_tag = ''
    if @model.get('featured_image_id')
      img_tag = """<img src='#{ @model.thumb_image_url() }' />"""

    html = """<a href='#/blog/show/#{id}'>
                #{ img_tag }
                <div>
                  <strong>#{ title }</strong>
                  <span class='right'><small>#{ draft_or_date }</small></span>
                </div>
                <div>
                  <small><em>#{ category_title }</em></small>
                </div>
              </a>"""
    $(this.el).html html
    return this


  initialize: ->
    @listenTo(@model, 'destroy', @remove)


Character.Blog.Views.BlogIndexPost = BlogIndexPost

