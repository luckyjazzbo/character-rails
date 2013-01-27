class BlogEditSettings extends Backbone.View
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


  #
  # Categories are not used by default
  #
  render_select_categories: ->
    post_category     = @model?.category()
    category_options  = '<option>No set</option>'

    @categories().each (c) ->
      if post_category and post_category.id == c.id
        category_options += """<option value='#{c.id}' selected>#{c.get('title')}</option>"""
      else
        category_options += """<option value='#{c.id}'>#{c.get('title')}</option>"""

    """<label>Pick a category for this post:</label>
       <select id=category_id class=categories>
         #{category_options}
       </select>"""


  render: ->
    date    = @model?.get('date')    ? ''
    excerpt = @model?.get('excerpt') ? ''
    tags    = @model?.get('tags')    ? ''

    featured_image_form_tag = @render_featured_image_form()
    category_options_tag    = if blog.options.categories then @category_options() else ''
    
    html = """<div class='chr-settings chr-form' id=settings_dlg style='display:none;'>
                #{ featured_image_form_tag }

                <input id=date class=datepicker type=text value='#{date}' placeholder='Date'>
                <textarea id=excerpt rows=5 placeholder='Excerpt'>#{excerpt}</textarea>
                <input type=text id=tags value='#{tags}' placeholder='Keywords splitted with comma' />

                #{ category_options_tag }
              </div>
              <button id=settings_btn class=chr-btn><i class='general foundicon-settings' /></button>"""
              
    $(this.el).html html
    return this


  initialize: ->
    html = @render().el
    $(html).attr('href', '#')
    $('#footer aside').prepend(html)

    @settings_btn = document.getElementById('settings_btn')
    @settings_dlg = document.getElementById('settings_dlg')

    @shown = false

    $('.datepicker').datepicker({ dateFormat: 'yy-mm-dd' })


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


  date: ->
    $('#date').val()
 

  excerpt: ->
    $('#excerpt').val()


  tags: ->
    $('#tags').val()


  category_id: ->
    $('#category_id').val()


  featured_image_id: ->
    $('#featured_image_demo').attr 'data-image-id'


Character.Blog.Views.BlogEditSettings = BlogEditSettings




