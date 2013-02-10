
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
  # Rendering
  #

  render: ->
    html = Character.Templates.Index
      title:        @options.title
      new_item_url: "#/#{ @options.scope }/new"

    $(this.el).html html
    return this
  

  action_url: (id) ->
    action_name = @options.render_item_options.action_name ? 'edit'
    "#/#{ @options.scope }/#{ action_name }/#{ id }"


  render_item: (model) ->
    config = { action_url: @action_url(model.id) }
    _.each @options.render_item_options, (val, key) -> config[key] = model.get(val)
    
    Character.Templates.IndexItem(config)


  render_placeholder: ->
    html = """<li class=chr-placeholder>
                You don't have any posts yet, so go ahead and create the first one!
              </li>"""
    $(@items_el).append html


  add_item: (model) ->
    item = new Character.IndexItemView
      model:  model
      html:   @render_item(model)
    
    $(@items_el).append item.el


  add_items: ->
    if @options.items
      objects = @options.items()
    else
      console.error 'IMPORTANT: index view options doesn\'t provide "collection" method!'
      objects = []

    (@render_placeholder() ; return) if objects.length == 0
    
    @add_item(obj) for obj in objects


  #
  # Sorting items
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
    $("#index_view a[href='#{ @action_url(id) }']").addClass('active')
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

    $(@panel_el).css('top', -window.scrollY + top_bar_height + app_top_padding)
    $(@panel_el).addClass('fixed')


  unlock_scroll: ->
    $(@panel_el).css('top', '').removeClass('fixed')
    window.scroll(0, workspace["#{ @options.scope }_index_scroll_y"])


  scroll_top: ->
    window.scroll(0, 0)


  flush_scroll_y: ->
    workspace["#{ @options.scope }_index_scroll_y"] = 0


  # Options are:
  #   @titlex
  #   @scope
  #   @reorderable
  #   @model_slug
  #   @items ->


  initialize: ->
    html = @render().el
    $('#character').append(html)

    @panel_el = this.$('.chr-panel')
    @items_el = this.$('ul')

    @add_items()

    @enable_sorting() if @options.reorderable

    if @options.collection
      collection = @options.collection()
      collection.on 'add',  (model) => @add_item(model)
      #collection.on 'sync', (collection) => alert 'kuku'


Character.IndexView = IndexView




#    #### ######## ######## ##     ## 
#     ##     ##    ##       ###   ### 
#     ##     ##    ##       #### #### 
#     ##     ##    ######   ## ### ## 
#     ##     ##    ##       ##     ## 
#     ##     ##    ##       ##     ## 
#    ####    ##    ######## ##     ## 




class IndexItemView extends Backbone.View
  tagName: 'li'


  render: ->
    $(this.el).html @options.html
    $(this.el).attr('data-id', @model.id)
    return this


  initialize: ->
    @listenTo(@model, 'destroy', @remove)
    @render()


Character.IndexItemView = IndexItemView


