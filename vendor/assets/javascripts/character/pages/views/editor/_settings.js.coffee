class Settings extends Character.Pages.Views.Base
  tagName:    'div'
  className:  'settings'
  id:         'settings'


  initialize: ->
    html = @render().el
    $('footer').append(html)

    @settings_btn = document.getElementById('settings_btn')

    @shown = false


  render: ->
    description = @model?.get('description') ? ''
    keywords    = @model?.get('keywords')    ? ''
    permalink   = @model?.get('permalink')   ? ''
    menu        = @model?.get('menu')  ? ''
    page        = @model?.toJSON()

    if page and page.featured_image_id
      featured_image_tag = """<img id=featured_image_demo
                                   data-image-id='#{}'
                                   class='featured-image-demo'
                                   src='#{@model.featured_image_url()}'
                                   style='width:100%;' />"""    
    else
      featured_image_tag = """<img id=featured_image_demo
                                   class='featured-image-demo'
                                   style='display:none; width:100%;' />"""    
    
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

                <label>Menu:</label>
                <input type=text id=menu class=menu value='#{menu}'/>

                <label>Permalink:</label>
                <input type=text id=permalink_override class=permalink value='#{permalink}'/>

                <label>Description:</label>
                <textarea id=description class=description rows=5>#{description}</textarea>

                <label>Keywords splitted with comma:</label>
                <input type=text id=keywords class=keywords value='#{keywords}'/>

              </div>
              <button class='general foundicon-settings' id=settings_btn></button>"""
    $(this.el).html html
    return this


  description: ->
    $('#description').val()


  permalink: ->
    $('#permalink_override').val()


  keywords: ->
    $('#keywords').val()


  menu: ->
    $('#menu').val()


  featured_image_id: ->
    $('#featured_image_demo').attr 'data-image-id'


  show_or_hide_settings_box: ->
    if @shown
      $(@el).removeClass('shown')
      @shown = false
    else
      @shown = true
      $(@el).addClass('shown')


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


Character.Pages.Views.Editor.Settings = Settings




