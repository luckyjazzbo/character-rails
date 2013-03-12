class Character.Pages.Views.Edit extends Backbone.View
  tagName:    'div'


  render: ->
    title = @model?.get('title') ? 'Page Title'

    html = """<header class='chr-panel' id=header>
                <input  id=title
                        class=chr-editor-title
                        type=text
                        placeholder='Page Title'
                        value='#{ title }' />
                <div class=chr-editor-permalink id=permalink></div>
              </header>

              <footer class='chr-footer' id=footer>
                <button class='chr-btn cancel'>Back to index</button>
                <aside>
                  <button class='chr-btn blue save'>Save Hidden</button>
                  <button class='chr-btn red publish'>Publish</button>
                </aside>
              </footer>"""

    $(this.el).html html
    return this


  initialize: ->
    html = @render().el
    $('#character').append(html)

    @title    = document.getElementById('title')
    @settings = new Character.Pages.Views.Settings model: @model
    @mode     = new Character.Pages.Views.Redactor model: @model
    
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
      @options.collection().create(attributes, { wait: true, success: callback })


  save_hidden: ->
    @update_or_create { published: false }


  publish: ->
    @update_or_create { published: true }, =>
      @back_to_index()


  back_to_index: ->
    index_path = @options.current_index_path()
    workspace.router.navigate(index_path, { trigger: true })


  events:
    'click .save':    'save_hidden'
    'click .publish': 'publish'
    'click .cancel':  'back_to_index'


  get_permalink: ->
    permalink = @settings.permalink()
    permalink = '/' + _.string.slugify($(@title).val()) if permalink == ''
    permalink


  update_permalink: ->
    set_permalink = =>
      permalink = @get_permalink()
      html      = """<strong>Permalink:</strong> <span id='slug'>#{permalink}</span>"""
      $('#permalink').html html

    $(@title).keyup => set_permalink()
    $('#permalink_override').keyup => set_permalink()
    set_permalink()








