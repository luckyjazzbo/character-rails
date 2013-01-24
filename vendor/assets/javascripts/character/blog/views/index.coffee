class BlogIndex extends Backbone.View
  tagName:    'div'
  id:         'posts'


  render: ->
    html = """<div class='six columns left-column' id=index>
                <div class='chr-container'>
                  <header>
                    <strong>Posts</strong>
                    <span class='buttons'>
                      <a href='#/blog/new' title='Create new post' class='icon-btn general foundicon-add-doc '></a>
                    </span>
                  </header>
                  <ul id='list' class='items-list no-bullets'></ul>
                </div>
              </div>"""
    $(this.el).html html
    return this


  render_items_placeholder: ->
    html = """<li>
                <div class='alert-box empty-list-msg center-text'>
                  You don't have any posts yet, so go ahead and create the first one!
                </div>
              </li>"""
    $(@list).append html


  render_item: (post) ->
    item = new Character.Blog.Views.BlogIndexPost model: post
    html = item.render().el
    $(@list).append html


  render_items: ->
    # drafts go first, then published posts
    drafts    = window.blog.posts.filter (p) -> not p.get('published')
    published = window.blog.posts.filter (p) -> p.get('published')

    # then published sorted by date
    reversed  = _(published).sortBy (p) -> p.get('date')
    sorted    = reversed.reverse()

    posts     = drafts.concat(sorted)

    if posts.length > 0
      @render_item(post) for post in posts
    else
      @render_items_placeholder()


  initialize: ->
    html = @render().el
    $('#app').append(html)

    if blog.options.categories
      @categories = new Character.Blog.Views.BlogCategories

    @list = document.getElementById('list')

    @render_items()


  scroll_to_active: ->
    if blog.index_scroll_y > 0
      window.scroll(0, blog.index_scroll_y)
    else
      top_offset = $('#posts a.active').offset().top
      if top_offset - window.scrollY > $(window).height()
        window.scroll(0, top_offset - 100)
  

  set_active: (id) ->
    @unset_active()
    $("#posts a[href='#/blog/show/#{id}']").addClass('active')
    @scroll_to_active()


  unset_active: ->
    $('#posts a.active').removeClass('active')


  lock: ->
    blog.index_scroll_y = window.scrollY

    top_bar_height  = $('.top-bar').height()
    app_top_padding = parseInt($('#app').css('padding-top'))

    $('#index').css('top', -window.scrollY + top_bar_height + app_top_padding)
               .addClass('fixed-position')


  unlock: ->
    $('#index').css('top', '').removeClass('fixed')
    window.scroll(0, blog.index_scroll_y)


  show_preview: (post_id) ->
    @set_active(post_id)

    if @preview then (@preview.remove() ; delete @preview) else @lock()
    
    post      = blog.posts.get(post_id)
    @preview  = new Character.Blog.Views.BlogIndexShow model: post
    
    html = @preview.render().el
    $(@el).append(html)

    window.scroll(0, 0)


  close_preview: ->
    @unlock()

    (@preview.remove() ; delete @preview) if @preview 

    @unset_active()
    blog.index_scroll_y = 0


Character.Blog.Views.BlogIndex = BlogIndex





