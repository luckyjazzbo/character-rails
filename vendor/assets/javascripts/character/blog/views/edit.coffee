class BlogEdit extends Backbone.View
  tagName:    'div'
  className:  'edit'


  render: ->
    title = if @model then @model.get('title') else 'The New Post'
    html = """<header class='twelve columns'>
                <input  type=text
                        placeholder='Post Title'
                        value='#{title}'
                        id=title
                        class=title />
                <div class=permalink id=permalink></div>
              </header>

              <footer>
                <button class='cancel btn'>Back to index</button>
                <span class='right-buttons'>
                  <button class='save-draft btn blue'>Save Draft</button>
                  <button class='publish btn red'>Publish</button>
                </span>
              </footer>"""
    $(this.el).html html
    return this


  initialize: ->
    html = @render().el
    $('#app').append(html)

    @title    = document.getElementById('title')    
    @mode     = new Character.Blog.Views.BlogEditMarkdown model: @model
    @settings = new Character.Blog.Views.BlogEditSettings model: @model
    
    @update_permalink()


  update_or_create_post: (extra_attributes, callback) ->
    title = $(@title).val()
    slug  = Character.Blog.Post.slugify(title)

    attributes =
      title:              title
      slug:               slug
      md:                 @mode.get_markdown()
      html:               @mode.get_html()
      date:               @settings.date()
      tags:               @settings.tags()
      excerpt:            @settings.excerpt()
      category_id:        @settings.category_id()
      featured_image_id:  @settings.featured_image_id()

    _.extend attributes, extra_attributes

    if @model
      @model.save(attributes, { success: callback })
    else
      blog.posts.create(attributes, { wait: true, success: callback })


  save_draft: ->
    @update_or_create_post {published: false}


  publish: ->
    @update_or_create_post {published: true}, =>    
      @back_to_index()


  back_to_index: ->
    path = if @model then "#/blog/show/#{@model.id}" else '#/blog'
    workspace.router.navigate(path, {trigger: true})


  events:
    'click .save-draft':              'save_draft'
    'click .publish':                 'publish'
    'click .cancel':                  'back_to_index'


  update_permalink: ->
    set_permalink = =>
      blog_url  = blog.options.blog_url
      slug      = Character.Blog.Post.slugify($(@title).val())
      html      = """<strong>Permalink:</strong> #{blog_url}<strong id='slug'>#{slug}</strong>"""
      $('#permalink').html html

    $(@title).keyup => set_permalink()
    set_permalink()


Character.Blog.Views.BlogEdit = BlogEdit







