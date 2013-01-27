class PagesEditSettings extends Backbone.View
  tagName:    'span'
  id:         'settings'


  render_featured_image: ->
    image_id  = @model?.get('featured_image_id')  ? ''
    image_url = @model?.featured_image_url()      ? ''

    """<img  id=featured_image_demo
             data-image-id='#{ image_id }'
             src='#{ image_url }'
             style='width:100%;' />"""    


  render_featured_image_form: ->
    featured_img_tag    = @render_featured_image()

    """<form  id=featured_image
              method=post
              action='/admin/character/images'
              enctype='multipart/form-data'>
          
          #{ featured_img_tag }
          
          <input name=_method type=hidden value=post>
          <input type=file id=image_uploader_input name='image' />
          <button class=submit style='float:right;'>Upload</button>
        </form>"""


  render: ->
    menu        = @model?.get('menu')         ? ''
    permalink   = @model?.get('permalink')    ? ''
    description = @model?.get('description')  ? ''
    keywords    = @model?.get('keywords')     ? ''

    featured_image_form_tag = @render_featured_image_form()
    
    html = """<div class='chr-settings chr-form' id=settings_dlg style='display:none;'>
                #{ featured_image_form_tag }

                <input type=text id=menu value='#{ menu }' placeholder='Menu name' />
                <input type=text id=permalink_override value='#{ permalink }' placeholder='Permalink' />
                <textarea id=description rows=5 placeholder='Description'>#{ description }</textarea>
                <input type=text id=keywords value='#{ keywords }' placeholder='Keywords splitted with comma' />
              </div>
              <button id=settings_btn class=chr-btn><i class='general foundicon-settings' /></button>"""
              
    $(this.el).html html
    return this


  initialize: ->
    html = @render().el

    $('#footer aside').prepend(html)

    @settings_btn = document.getElementById('settings_btn')
    @settings_dlg = document.getElementById('settings_dlg')

    @shown = false


  show_or_hide_settings_box: ->
    if @shown
      @shown = false ; $(@settings_dlg).hide()
    else
      @shown = true ; $(@settings_dlg).show()


  upload_featured_image: ->
    form = $('#featured_image')
    form.ajaxForm
      success: (obj) =>
        $('#featured_image_demo').attr 'src', obj.featured
        $('#featured_image_demo').attr 'data-image-id', obj._id
        $('#featured_image_demo').show()


  events:
    'click #settings_btn':  'show_or_hide_settings_box'
    'click .submit':        'upload_featured_image'


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


Character.Pages.Views.PagesEditSettings = PagesEditSettings






