class Editor extends Character.Blog.Views.Base
  tagName:    'div'
  className:  'editor'


  initialize: ->
    html = @render().el
    $('#main').append(html)

    @settings   = new Character.Blog.Views.Editor.Settings model: @model
    @converter  = new Showdown.converter { extensions: ['github', 'image_uploader', 'video'] }

    @title      = document.getElementById('title')
    @html       = document.getElementById('html')
    
    @enable_codemirror()
    @resize_panels()
    @update_permalink()
    


  update_or_create_post: (extra_attributes, callback) ->
    slug = Character.Blog.Post.slugify($(@title).val())

    attributes =
      title:              $(@title).val()
      md:                 @markdown()
      html:               @html.innerHTML
      slug:               slug
      date:               @settings.date()
      tags:               @settings.tags()
      excerpt:            @settings.excerpt()
      category_id:        @settings.category_id()
      featured_image_id:  @settings.featured_image_id()

    _.extend attributes, extra_attributes

    if @model
      @model.save(attributes, { success: callback })
    else
      @posts().create(attributes, { wait: true, success: callback })


  save_draft: ->
    @update_or_create_post {published: false}, =>    
      @back_to_index()


  publish: ->
    @update_or_create_post {published: true}, =>    
      @back_to_index()


  back_to_index: ->
    path = if @model then "#/preview/#{@model.id}" else '#/'
    @router().navigate(path, {trigger: true})


  upload_image: (e) ->
    form = $(e.currentTarget).parent()

    form_index = $('article .image-uploader').index(form) + 1

    form.ajaxForm
      success: (obj) =>
        image_url       = obj.image.common.url

        md_text         = "\n" + @markdown() + "\n" # edge cases workaround
        updated_md_text = md_text.replace_nth_occurrence("\n(image)\n", "\n![](#{image_url})\n", form_index)
        
        updated_md_text = updated_md_text.slice(1,updated_md_text.length - 1)

        @code_mirror.setValue(updated_md_text)
        @convert_text()


  events:
    'click .save-draft':              'save_draft'
    'click .publish':                 'publish'
    'click .cancel':                  'back_to_index'
    'click .image-uploader .submit':  'upload_image'


  update_permalink: ->
    set_permalink = =>
      blog_url  = 'http://test.com/' #@app().blog_url
      slug      = Character.Blog.Post.slugify($(@title).val())
      html      = """<strong>Permalink:</strong> #{blog_url}<strong id='slug'>#{slug}</strong>"""
      $('#permalink').html html

    $(@title).keyup -> set_permalink()
    set_permalink()


  render: ->
    post  = if @model then @model.toJSON() else {title: 'Post Title', md: 'Post Text'}
    state = if @model then @model.state() else 'New'

    html = """<header>
                <div class='title'>
                  <input type='text' placeholder='Title' value='#{post.title}' id='title'/>
                </div>
                <div class='permalink' id='permalink'>
                </div>
              </header>

              <div class='chr-panel left index fixed'>
                <section class='container'>
                  <header>
                    <span class='title'>Markdown</span>
                    <span class='buttons'>
                      <a href='http://daringfireball.net/projects/markdown/syntax' title='Markdown syntax' class='general foundicon-idea' target=_blank></a>
                    </span>
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
                  </header>

                  <article>
                    <section class='content' id='html'></section>
                  </article>
                </section>
              </div>

              <footer>
                <button class='cancel'>Back to index</button>
                <button class='publish'>Publish</button>
                <button class='save-draft'>Save Draft</button>
              </footer>"""
    $(this.el).html html
    return this


  convert_text: ->
    text = @markdown()
    @html.innerHTML = @converter.makeHtml(text)


  resize_panels: ->
    html          = $(@html).parent()
    window_height = $(window).height()
    footer_height = $('footer').outerHeight()
    
    html.css     'height', window_height - html.offset().top - footer_height
    $('.CodeMirror').css 'height', window_height - html.offset().top - footer_height
    
    $(window).smartresize =>
      @resize_panels()


  destroy: ->
    @code_mirror.off 'change'
    @markdown.onkeyup = null
    @title.onkeyup    = null


  enable_codemirror: ->
    options =
      mode:           'text/x-markdown'
      lineWrapping:   true
      autofocus:      true

    markdown = document.getElementById('markdown')
    @code_mirror = CodeMirror.fromTextArea(markdown, options)
    @code_mirror.on 'change', => @convert_text()
    @convert_text()


  markdown: ->
    @code_mirror.getValue()


Character.Blog.Views.Editor.Editor = Editor







