class PagesEditRedactor extends Backbone.View
  tagName:    'div'

  render: ->
    post  = if @model then @model.toJSON() else { html: ''}
    state = if @model then @model.state()  else 'New Page'

    html = """<div class='twelve columns'>
                <div class='container'>
                  <header class='align-right'>
                    <strong>#{ state }</strong>
                  </header>
                  <div>
                    <textarea id='html'>#{post.html}</textarea>
                  </div>
                </div>
              </div>"""

    $(this.el).html html
    return this


  initialize: ->
    html = @render().el
    $('.edit header').after(html)

    @html = document.getElementById('html')
    
    $(@html).redactor
      convertLinks: false
      convertDivs: false
      callback: => @resize_panels()
      #autoresize: false
      #air: true


  resize_panels: ->
    top_offset    = 153 # top offset
    window_height = $(window).height()
    footer_height = $('footer').outerHeight()
    
    $('.redactor_editor').css 'height', window_height - top_offset - footer_height
    
    $(window).smartresize =>
      @resize_panels()


  destroy: ->
    # remove redactor


  get_html: ->
    @html.value


Character.Pages.Views.PagesEditRedactor = PagesEditRedactor



