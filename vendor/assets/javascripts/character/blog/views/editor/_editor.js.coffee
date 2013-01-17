class Editor extends Character.Blog.Views.Base
  tagName:    'div'
  className:  'editor'


  initialize: ->
    html = @render().el
    $('#main').append(html)

    @settings   = new Character.Blog.Views.Editor.Settings model: @model
    @converter  = new Showdown.converter { extensions: ['github', 'image_uploader', 'video'] }

    
    @title  = document.getElementById('title')
    
    if @app().options.edit_mode == 'redactor'
      @mode = new Character.Blog.Views.Editor.Redactor model: @model
    else
      @mode = new Character.Blog.Views.Editor.Markdown model: @model
    
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
      @posts().create(attributes, { wait: true, success: callback })


  save_draft: ->
    @update_or_create_post {published: false}, =>    
      @back_to_index()


  publish: ->
    @update_or_create_post {published: true}, =>    
      @back_to_index()


  back_to_index: ->
    path = if @model then "#/preview/#{@model.id}" else '#/'
    @router().navigate(path, {trigger: true})


  events:
    'click .save-draft':              'save_draft'
    'click .publish':                 'publish'
    'click .cancel':                  'back_to_index'


  update_permalink: ->
    set_permalink = =>
      blog_url  = @app().options.blog_url
      slug      = Character.Blog.Post.slugify($(@title).val())
      html      = """<strong>Permalink:</strong> #{blog_url}<strong id='slug'>#{slug}</strong>"""
      $('#permalink').html html

    $(@title).keyup => set_permalink()
    set_permalink()


  render: ->
    post = if @model then @model.toJSON() else {title: 'Post Title', md: 'Post Text'}
    html = """<header>
                <div class='title'>
                  <input type='text' placeholder='Title' value='#{post.title}' id='title'/>
                </div>
                <div class='permalink' id='permalink'>
                </div>
              </header>

              <footer>
                <button class='cancel'>Back to index</button>
                <button class='publish'>Publish</button>
                <button class='save-draft'>Save Draft</button>
              </footer>"""
    $(this.el).html html
    return this


  destroy: ->
    delete @mode


Character.Blog.Views.Editor.Editor = Editor







