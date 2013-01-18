class Codemirror extends Character.Pages.Views.Base
  tagName:    'div'
  className:  'mode html'

  initialize: ->
    html = @render().el
    $('.editor header').after(html)

    @code_mirror = CodeMirror.fromTextArea document.getElementById('html'),
      mode:         'text/html'
      lineWrapping: true
      autofocus:    true

    @resize_panels()


  render: ->
    page  = if @model then @model.toJSON() else {html: ''}
    state = if @model then @model.state()  else 'New'

    html = """<div class='chr-panel center fixed'>
                <section class='container'>
                  <header>
                    <span class='title'>#{state}</span>
                  </header>
                  <div>
                    <textarea id='html' style='display:none;'>#{page.html}</textarea>
                  </div>
                </section>
              </div>"""

    $(this.el).html html
    return this


  resize_panels: ->
    top_offset    = $('.CodeMirror').offset().top
    window_height = $(window).height()
    footer_height = $('footer').outerHeight()
    
    $('.CodeMirror').css 'height', window_height - footer_height - top_offset
    
    $(window).smartresize =>
      @resize_panels()


  destroy: ->
    @code_mirror.off 'change'


  get_html: ->
    @code_mirror.getValue()


Character.Pages.Views.Editor.Codemirror = Codemirror








