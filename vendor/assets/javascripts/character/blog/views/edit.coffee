class BlogEdit extends Backbone.View
  tagName:    'div'


  render: ->
    title = if @model then @model.get('title') else 'The New Post'
    html = """<header class='chr-panel' id=header>
                <input  id=title
                        class=chr-editor-title
                        type=text
                        placeholder='Post Title'
                        value='#{title}' />
                <div class=chr-editor-permalink id=permalink></div>
              </header>

              <footer class='chr-footer' id=footer>
                <button class='chr-btn cancel'>Back to index</button>
                <aside>
                  <button class='chr-btn blue save-draft'>Save Draft</button>
                  <button class='chr-btn red publish'>Publish</button>
                </aside>
              </footer>"""
    $(this.el).html html
    return this


  initialize: ->
    html = @render().el
    $('#character').append(html)

    @title    = document.getElementById('title')    
    @mode     = new Character.Blog.Views.BlogEditMarkdown model: @model
    @settings = new Character.Blog.Views.BlogEditSettings model: @model
    
    @update_permalink()


  update_or_create_post: (extra_attributes, callback) ->
    title = $(@title).val()
    slug  = _.string.slugify(title)

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
      featured:           @settings.featured()

    _.extend attributes, extra_attributes

    if @model
      console.log attributes
      @model.save(attributes, { success: callback })
    else
      blog.posts.create(attributes, { wait: true, success: callback })


  save_draft: ->
    @update_or_create_post {published: false}, =>
      @back_to_index()


  publish: ->
    @update_or_create_post {published: true}, =>    
      @back_to_index()


  back_to_index: ->
    path = if @model then "#/blog/show/#{@model.id}" else '#/blog'
    workspace.router.navigate(path, {trigger: true})


  events:
    'click .save-draft': 'save_draft'
    'click .publish':    'publish'
    'click .cancel':     'back_to_index'


  update_permalink: ->
    set_permalink = =>
      blog_url  = blog.options.blog_url
      slug      = _.string.slugify($(@title).val())
      html      = """<strong>Permalink:</strong> #{blog_url}<strong id='slug'>#{slug}</strong>"""
      $('#permalink').html html

    $(@title).keyup => set_permalink()
    set_permalink()


Character.Blog.Views.BlogEdit = BlogEdit







