###############################
### CHARACTER :: EditorView ###
###############################

# Code is partly taken from:
# - http://www.showdown.im/showdown/example/showdown-gui.js

class EditorView extends Backbone.View
  tagName:    'div'
  className:  'editor'


  initialize: ->
    html = @render().el
    $('#main').append(html)

    @settings = new EditorSettingsView model: @model

    @converter  = new Showdown.converter()
    @last_text  = null
    @title      = document.getElementById('title')
    @update_permalink()

    @slug       = document.getElementById('slug')
    @markdown   = document.getElementById('markdown')
    @html       = document.getElementById('html')
    @max_delay  = 3000
    
    @resize_panels()
    @typing_events()
    @convert_text()


  update_or_create_post: (extra_attributes, callback) ->
    attributes =
      title:  $(@title).val()
      md:     $(@markdown).val()
      html:   @html.innerHTML
      slug:   Post.slugify($(@title).val())
      date:   @settings.date()

    _.extend attributes, extra_attributes

    if @model
      @model.save(attributes, {success: callback})
    else
      window.posts.create(attributes, {wait: true, success: callback})


  save_draft: ->
    @update_or_create_post {published: false}, =>    
      @back_to_index()


  publish: ->
    @update_or_create_post {published: true}, =>    
      @back_to_index()


  back_to_index: ->
    path = if @model then "#/preview/#{@model.id}" else '#/'
    router.navigate(path, {trigger: true})


  events:
    'click .save-draft':  'save_draft'
    'click .publish':     'publish'
    'click .cancel':      'back_to_index'


  update_word_counter: ->
    counter = 0
    md_text = $(@markdown).val()
    if md_text.length > 0
      counter = md_text.match(/[^\s]+/g).length
    $(document.getElementById('word_counter')).html "#{counter} words"


  update_permalink: ->
    blog_url  = window.app.blog_url
    slug      = Post.slugify($(@title).val())
    html = """<strong>Permalink:</strong> #{blog_url}<strong id='slug'>#{slug}</strong>"""
    $('#permalink').html html


  render: ->
    post = if @model then @model.toJSON() else {title: 'Post Title', md: 'Post Text'}

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
                      <a href='#' title='Markdown syntax' class='foundicon-help'></a>
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
                    <span class='title'>Preview</span>
                    <span class='info' id='word_counter'>549 words</span>
                  </header>

                  <article>
                    <section class='content' id='html'></section>
                  </article>
                </section>
              </div>

              <footer>
                <button class='cancel'>Cancel</button>
                <button class='publish'>Publish</button>
                <button class='save-draft'>Save Draft</button>
              </footer>"""
    $(this.el).html html
    return this


  on_input: (callback) ->
    # In "delayed" mode, we do the conversion at pauses in input.
    # The pause is equal to the last runtime, so that slow
    # updates happen less frequently.
    #
    # Use a timer to schedule updates.  Each keystroke
    # resets the timer.

    # if we already have convertText scheduled, cancel it
    if convert_text_timer
      window.clearTimeout(convert_text_timer)
      convert_text_timer = null

    time_until_convert_text = 0

    if time_until_convert_text > @max_delay
      time_until_convert_text = @max_delay

    # Schedule @convert_text().
    # Even if we're updating every keystroke, use a timer at 0.
    # This gives the browser time to handle other events.
    convert_text_timer = window.setTimeout(callback, time_until_convert_text)


  typing_events: ->
    # First, try registering for keyup events
    # (There's no harm in calling onInput() repeatedly)
    @markdown.onkeyup = => @on_input(@convert_text)
    @title.onkeyup    = => @on_input(@update_permalink)

    # In case we can't capture paste events, poll for them
    polling_fallback = window.setInterval ( => @on_input() if not @markdown.value == @last_text ), 1000

    # Try registering for paste events
    @markdown.onpaste = =>
      # It worked! Cancel paste polling.
      if polling_fallback
        window.clearInterval(polling_fallback)
        polling_fallback = null
      @on_input()

    # Try registering for input events (the best solution)
    if @markdown.addEventListener
      # Let's assume input also fires on paste.
      # No need to cancel our keyup handlers;
      # they're basically free.
      @markdown.addEventListener('input', @markdown.onpaste, false)

    @markdown.focus()


  convert_text: =>
    text = @markdown.value

    return if text and text == @last_text

    @last_text = text

    # do the conversion
    @html.innerHTML = @converter.makeHtml(text)
    @update_word_counter()


  resize_panels: ->
    markdown      = $(@markdown)
    html          = $(@html).parent()
    window_height = $(window).height()
    footer_height = $('footer').outerHeight()
    
    markdown.css 'height', window_height - markdown.offset().top - footer_height
    html.css     'height', window_height - html.offset().top - footer_height
    
    $(window).smartresize =>
      @resize_panels()


  destroy = ->
    # clear smartresize event
    @markdown.onkeyup = null
    @title.onkeyup    = null


window.EditorView = EditorView








