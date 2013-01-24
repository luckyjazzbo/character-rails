class PagesEdit extends Backbone.View
  tagName:    'div'
  className:  'edit'


  render: ->
    page = if @model then @model.toJSON() else { title: 'Page Title', html: 'Page Sources' }
    html = """<header class='twelve columns'>
                <input  type=text
                        placeholder='Page Title'
                        value='#{ page.title }'
                        id=title
                        class=title />
                <div class=permalink id=permalink></div>
              </header>

              <footer class='chr-footer'>
                <button class='cancel btn'>Back to index</button>
                <span class='right-buttons'>
                  <button class='save btn blue'>Save Hidden</button>
                  <button class='publish btn red'>Publish</button>
                </span>
              </footer>"""
    $(this.el).html html
    return this


  initialize: ->
    html = @render().el
    $('#app').append(html)

    @title = document.getElementById('title')
    @settings = new Character.Pages.Views.PagesEditSettings model: @model
    
    @mode = new Character.Pages.Views.PagesEditRedactor model: @model
    
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
      pages.pages.create(attributes, { wait: true, success: callback })


  save_hidden: ->
    @update_or_create {published: false}


  publish: ->
    @update_or_create {published: true}, =>    
      @back_to_index()


  back_to_index: ->
    workspace.router.navigate('#/pages', {trigger: true})


  events:
    'click .save':    'save_hidden'
    'click .publish': 'publish'
    'click .cancel':  'back_to_index'


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


Character.Pages.Views.PagesEdit = PagesEdit







