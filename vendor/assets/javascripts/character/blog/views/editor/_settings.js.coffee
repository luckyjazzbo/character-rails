class Settings extends Character.Blog.Views.Base
  tagName:    'div'
  className:  'settings'
  id:         'settings'


  initialize: ->
    html = @render().el
    $('footer').append(html)

    @settings_btn = document.getElementById('settings_btn')

    @shown = false


  render: ->
    date    = @model?.get('date')    ? ''
    excerpt = @model?.get('excerpt') ? ''
    tags    = @model?.get('tags')    ? ''

    post_category     = @model?.category()
    category_options  = '<option>No set</option>'

    post = @model?.toJSON()

    if post and post.featured_image_id
      featured_image_tag = """<img id=featured_image_demo
                                   data-image-id='#{}'
                                   class='featured-image-demo'
                                   src='#{@model.featured_image_url()}'
                                   style='width:100%;' />"""    
    else
      featured_image_tag = """<img id=featured_image_demo
                                   class='featured-image-demo'
                                   style='display:none; width:100%;' />"""    
    
    
    @categories().each (c) ->
      if post_category and post_category.id == c.id
        category_options += """<option value='#{c.id}' selected>#{c.get('title')}</option>"""
      else
        category_options += """<option value='#{c.id}'>#{c.get('title')}</option>"""

    html = """<div class='settings-box'>
                <form id=featured_image
                      class='featured-image-form'
                      method=post
                      action='/admin/character/images'
                      enctype='multipart/form-data'
                      style='width:100%;margin-bottom:.5em;'>
                  #{featured_image_tag}
                  <input name=_method type=hidden value=post>
                  <input name=authenticity_token type=hidden value="#{window.authenticity_token()}">
                  <input type=file id=image_uploader_input name='image' />
                  <button class='submit' style='float:right;'>Upload</button>
                </form>

                <i class='general foundicon-calendar'></i> <input id=date type=date value='#{date}' class=date>

                <label>Excerpt:</label>
                <textarea id=excerpt class=excerpt rows=5>#{excerpt}</textarea>

                <label>Keywords splitted with comma:</label>
                <input type=text id=tags class=tags value='#{tags}'/>

                <label>Pick a category for this post:</label>
                <select id=category_id class=categories>
                  #{category_options}
                </select>
              </div>
              <button class='general foundicon-settings' id=settings_btn></button>"""
    $(this.el).html html
    return this


  date: ->
    $('#date').val()
 

  excerpt: ->
    $('#excerpt').val()


  tags: ->
    $('#tags').val()


  show_or_hide_settings_box: ->
    if @shown
      $(@el).removeClass('shown')
      @shown = false
    else
      @shown = true
      $(@el).addClass('shown')


  category_id: ->
    $('#category_id').val()


  featured_image_id: ->
    $('#featured_image_demo').attr 'data-image-id'


  upload_featured_image: ->
    form = $('#featured_image')
    form.ajaxForm
      success: (obj) =>
        $('#featured_image_demo').attr 'src', obj.image.featured.url
        $('#featured_image_demo').attr 'data-image-id', obj._id
        $('#featured_image_demo').show()


  events:
    'click #settings_btn':                'show_or_hide_settings_box'
    'click .featured-image-form .submit': 'upload_featured_image'


Character.Blog.Views.Editor.Settings = Settings




