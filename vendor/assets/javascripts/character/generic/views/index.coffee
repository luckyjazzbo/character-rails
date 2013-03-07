

#    #### ##    ## ########  ######## ##     ## 
#     ##  ###   ## ##     ## ##        ##   ##  
#     ##  ####  ## ##     ## ##         ## ##   
#     ##  ## ## ## ##     ## ######      ###    
#     ##  ##  #### ##     ## ##         ## ##   
#     ##  ##   ### ##     ## ##        ##   ##  
#    #### ##    ## ########  ######## ##     ## 


class IndexView extends Backbone.View
  tagName:    'div'
  id:         'index_view'


  #
  # Resizing min-height of the panels
  #

  resize_panel: ->
    top_nav_height      = 40
    margin_top_bottom   = 14 * 2
    panel_header_height = 34
    paginate_height     = 24 #if @options.paginate then 24 else 0
    window_height       = $(window).innerHeight()

    index_min_height = window_height - (top_nav_height + margin_top_bottom + panel_header_height + paginate_height) 
    panel_min_height = window_height - (top_nav_height + margin_top_bottom + panel_header_height) + paginate_height + 10

    $('.chr-index').css               'min-height', index_min_height
    $('.chr-panel.left section').css  'min-height', panel_min_height

    item_height = 71

    if @options.paginate
      collection = @options.collection()
      collection.paginate.per_page = Math.floor((index_min_height - paginate_height) / item_height)
    
    $(window).smartresize =>
      @resize_panel()


  #
  # Sorting items with Drag'n'Drop
  #

  enable_sorting: ->
    sort_options =
      stop: (e, ui) =>
        ids = this.$('li').map(-> $(this).attr('data-id')).get()        
        $.post "/admin/api/#{ @options.model_slug }/reorder", { _method: 'post', ids: ids }

    $(@items_el).sortable(sort_options).disableSelection()


  #
  # Navigation experience
  #

  set_active: (id) ->
    @unset_active()
    $("#index_view li[data-id=#{ id }] a").addClass('active')
    @scroll_to_active()


  unset_active: ->
    $('#index_view a.active').removeClass('active')


  scroll_to_active: ->
    scroll_y = workspace["#{ @options.scope }_index_scroll_y"]
    
    if scroll_y and scroll_y > 0
      window.scroll(0, scroll_y)
    else
      top_offset = $('#index_view a.active').offset().top
      if top_offset - window.scrollY > $(window).height()
        window.scroll(0, top_offset - 100)
  

  lock_scroll: ->
    workspace["#{ @options.scope }_index_scroll_y"] = window.scrollY

    top_bar_height  = $('.top-bar').height()
    app_top_padding = parseInt($('#character').css('padding-top'))

    $(@panel_el).css('top', -window.scrollY + top_bar_height + app_top_padding + 1)
    $(@panel_el).addClass('fixed')


  unlock_scroll: ->
    $(@panel_el).css('top', '').removeClass('fixed')
    window.scroll(0, workspace["#{ @options.scope }_index_scroll_y"])


  scroll_top: ->
    window.scroll(0, 0)


  flush_scroll_y: ->
    workspace["#{ @options.scope }_index_scroll_y"] = 0


  events:
    'keypress #search_input': 'search'


  search: (e) ->
    if e.charCode == 13
      value = $('#search_input').val()

      path  = "#/#{ @options.scope }"
      path  = "#{ path }/search/#{ value }" if value
      
      workspace.router.navigate(path, { trigger: true })


  initialize: ->
    @render()
    @resize_panel()

    collection = @options.collection()

    collection.on('add',   @add_item,  @)
    collection.on('reset', @add_items, @)


  #
  # Rendering
  #


  render: ->
    html = Character.Templates.Index
      title:        @options.title
      searchable:   @options.searchable
      search_query: @options.collection().search_query
      index_url:    "#/#{ @options.scope }"
      new_item_url: "#/#{ @options.scope }/new"

    @$el.html html

    $('#character').append @el

    @panel_el = this.$('.chr-panel')
    @items_el = this.$('ul')


  add_item: (model) ->
    # TODO: remove placeholder on adding first item

    item = new Character.IndexItemView
      model:                model
      current_index_path:   @options.current_index_path()
      render_item_options:  @options.render_item_options
    
    $(@items_el).append item.el


  render_placeholder: ->
    $(@items_el).append """<li class=chr-placeholder>Nothing is here yet.</li>"""


  add_items: ->
    $(@items_el).empty()

    if @options.items
      objects = @options.items()
    else
      console.error 'IMPORTANT: index view options doesn\'t provide "collection" method!'
      objects = []

    (@render_placeholder() ; return) if objects.length == 0
    
    @add_item(obj) for obj in objects

    # Truncate lines
    $('.chr-line-1 .chr-line-left').trunk8 { lines: 1 }
    $('.chr-line-2 .chr-line-left').trunk8 { lines: 2 }

    # Sorting with drag'n'drop
    @enable_sorting() if @options.reorderable

    # Add paginate
    @paginate_view = new Character.IndexPaginateView(@options) if @options.paginate and not @paginate_view
    @paginate_view.render()




Character.IndexView = IndexView





