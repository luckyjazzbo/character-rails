class Editor extends Character.Pages.Views.Base
  tagName:    'div'
  className:  'editor'


  initialize: (options) ->
    @model = options.model

    html = @render().el
    $('#main').append(html)

    @settings = new Character.Pages.Views.Editor.Settings model: @model
    @title    = document.getElementById('title')
    
    if options.redactor
      @mode = new Character.Pages.Views.Editor.Redactor model: @model
    else
      @mode = new Character.Pages.Views.Editor.Codemirror model: @model
    
    @update_permalink()


  update_or_create: (extra_attributes, callback) ->
    title     = $(@title).val()
    permalink = @get_permalink()

    attributes =
      title:              title
      permalink:          permalink
      html:               @mode.get_html()
      menu:               @settings.menu()
      keywords:           @settings.keywords()
      description:        @settings.description()
      featured_image_id:  @settings.featured_image_id()

    _.extend attributes, extra_attributes

    if @model
      @model.save(attributes, { success: callback })
    else
      @pages().create(attributes, { wait: true, success: callback })


  save_hidden: ->
    @update_or_create {published: false}, =>    
      @back_to_index()


  publish: ->
    @update_or_create {published: true}, =>    
      @back_to_index()


  back_to_index: ->
    @router().navigate('#/', {trigger: true})


  events:
    'click .save-draft':              'save_hidden'
    'click .publish':                 'publish'
    'click .cancel':                  'back_to_index'


  get_permalink: ->
    permalink = @settings.permalink()
    permalink = '/' + Character.Pages.Page.slugify($(@title).val()) if permalink == ''
    permalink


  update_permalink: ->
    set_permalink = =>
      permalink = @get_permalink()
      html      = """<strong>Permalink:</strong> <span id='slug'>#{permalink}</span>"""
      $('#permalink').html html

    $(@title).keyup => set_permalink()
    $('#permalink_override').keyup => set_permalink()
    set_permalink()


  render: ->
    page = if @model then @model.toJSON() else {title: 'Page Title', html: 'Page Sources'}
    html = """<header>
                <div class='title'>
                  <input type='text' placeholder='Title' value='#{page.title}' id='title'/>
                </div>
                <div class='permalink' id='permalink'></div>
              </header>

              <footer>
                <button class='cancel'>Back to index</button>
                <button class='publish'>Publish</button>
                <button class='save-draft'>Save Hidden</button>
              </footer>"""
    $(this.el).html html
    return this


  destroy: ->
    delete @mode


Character.Pages.Views.Editor.Editor = Editor







