class BlogEditMarkdown extends Backbone.View
  tagName:    'div'

  render_markdown: (markdown) ->
    """<div class='six columns left-column'>
         <section class='container'>
           <header><strong>Markdown</strong></header>
           <div>
             <textarea id='markdown'>#{ markdown }</textarea>
           </div>
         </section>
       </div>"""


  render_preview: (state) ->
    """<div class='six columns right-column'>
          <div class='container'>
            <header><strong>#{ state }</strong></header>
            <article class='item-preview'>
              <section class=content id=html></section>
            </article>
          </div>
        </div>"""
  

  render: ->
    post  = if @model then @model.toJSON() else { md: 'Post Text' }
    state = if @model then @model.state()  else 'New'

    html = @render_markdown(post.md) + @render_preview(state)

    $(this.el).html html
    return this


  initialize: ->
    html = @render().el
    $('.edit header').after(html)

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


  convert_text: ->
    text = @get_markdown()
    @html.innerHTML = @converter.makeHtml(text)


  get_markdown: ->
    @code_mirror.getValue()


  resize_panels: ->
    article       = $(@html).parent()

    article_top_offset  = 153 #article.offset().top
    window_height       = $(window).height()
    footer_height       = $('footer').outerHeight()
    
    article.css          'height', window_height - article_top_offset - footer_height
    $('.CodeMirror').css 'height', window_height - article_top_offset - footer_height
    
    $(window).smartresize =>
      @resize_panels()


Character.Blog.Views.BlogEditMarkdown = BlogEditMarkdown








