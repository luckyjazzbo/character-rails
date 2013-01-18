class Markdown extends Character.Blog.Views.Base
  tagName:    'div'
  className:  'mode markdown'

  initialize: ->
    html = @render().el
    $('.editor header').after(html)

    @converter  = new Showdown.converter { extensions: ['github', 'image_uploader', 'video'] }
    @html       = document.getElementById('html')
    
    @code_mirror = CodeMirror.fromTextArea document.getElementById('markdown'),
      mode:         'text/x-markdown'
      lineWrapping: true
      autofocus:    true

    @code_mirror.on 'change', => @convert_text()

    @convert_text()
    @resize_panels()


  get_html: ->
    @html.innerHTML


  upload_image: (e) ->
    form = $(e.currentTarget).parent()

    form_index = $('article .image-uploader').index(form) + 1

    form.ajaxForm
      success: (obj) =>
        image_url       = obj.image.common.url

        md_text         = "\n" + @get_markdown() + "\n" # edge cases workaround
        updated_md_text = md_text.replace_nth_occurrence("\n(image)\n", "\n![](#{image_url})\n", form_index)
        
        updated_md_text = updated_md_text.slice(1,updated_md_text.length - 1)

        @code_mirror.setValue(updated_md_text)
        @convert_text()


  events:
    'click .image-uploader .submit':  'upload_image'


  render: ->
    post  = if @model then @model.toJSON() else {title: 'Post Title', md: 'Post Text'}
    state = if @model then @model.state()  else 'New'

    html = """<div class='chr-panel left fixed'>
                <section class='container'>
                  <header>
                    <span class='title'>Markdown</span>
                  </header>
                  <div>
                    <textarea id='markdown'>#{post.md}</textarea>
                  </div>
                </section>
              </div>

              <div class='chr-panel right preview fixed'>
                <section class='container'>
                  <header>
                    <span class='title'>#{state}</span>
                    <!--<span class='info' id='word_counter'>549 words</span>-->
                    </span>
                  </header>

                  <article class='markdown-preview'>
                    <section class='content' id='html'></section>
                  </article>
                </section>
              </div>"""

    $(this.el).html html
    return this


  convert_text: ->
    text = @get_markdown()
    @html.innerHTML = @converter.makeHtml(text)


  resize_panels: ->
    html          = $(@html).parent()
    window_height = $(window).height()
    footer_height = $('footer').outerHeight()
    
    html.css              'height', window_height - html.offset().top - footer_height
    $('.CodeMirror').css  'height', window_height - html.offset().top - footer_height
    
    $(window).smartresize =>
      @resize_panels()


  destroy: ->
    @code_mirror.off 'change'


  get_markdown: ->
    @code_mirror.getValue()


Character.Blog.Views.Editor.Markdown = Markdown








