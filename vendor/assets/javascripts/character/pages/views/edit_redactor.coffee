class PagesEditRedactor extends Backbone.View
  tagName:    'div'

  render: ->
    html  = @model?.get('html') ? ''
    state = @model?.state()     ? 'New Page'

    html = """<div class='chr-panel chr-redactor'>
                <section>
                  <header>
                    <strong>#{ state }</strong>
                  </header>
                  <div>
                    <textarea id='html'>#{ html }</textarea>
                  </div>
                </section>
              </div>"""

    $(this.el).html html
    return this


  initialize: ->
    html = @render().el
    $('#header').after(html)

    @html = document.getElementById('html')
    
    $(@html).redactor
      convertLinks: false
      convertDivs:  false
      buttons:      ['html', '|', 'bold', 'italic', 'deleted', '|', 'image', '|', 'link' ]
      imageGetJson: '/admin/character/images'
      imageUpload:  '/admin/character/images'
      callback: => @resize_panels()


  resize_panels: ->
    top_offset    = 156
    window_height = $(window).height()
    footer_height = $('footer').outerHeight()
    
    $('.redactor_editor').css 'height', window_height - top_offset - footer_height
    
    $(window).smartresize =>
      @resize_panels()


  get_html: ->
    @html.value


Character.Pages.Views.PagesEditRedactor = PagesEditRedactor



