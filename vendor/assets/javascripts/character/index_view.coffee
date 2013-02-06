
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


  render: ->
    html = Character.Templates.Index
      title:        @options.title
      new_item_url: "#/#{ @options.scope }/new"

    $(this.el).html html
    return this
  

  render_item: (model) ->
    action_name = @options.render_item_options.action_name ? 'edit'
    config      = { action_url: "#/#{ @options.scope }/#{ action_name }/#{ model.id }" }

    _.each @options.render_item_options, (val, key) -> config[key] = model.get(val)
    
    Character.Templates.IndexItem(config)


  render_placeholder: ->
    html = """<li class=chr-placeholder>
                You don't have any posts yet, so go ahead and create the first one!
              </li>"""
    $(@items_el).append html


  render_items: ->
    if @options.items
      objects = @options.items()
    else
      console.error 'IMPORTANT: index view options doesn\'t provide "collection" method!'
      objects = []

    (@render_placeholder() ; return) if objects.length == 0
    
    _(objects).each (obj) =>
      item = new Character.IndexItemView
        model:  obj
        html:   @render_item(obj)
      
      $(@items_el).append item.el


  enable_sorting: ->
    sort_options =
      stop: (e, ui) =>
        ids = this.$('li').map(-> $(this).attr('data-id')).get()        
        $.post "/admin/api/#{ @options.model_slug }/reorder", { _method: 'post', ids: ids }

    $(@items_el).sortable(sort_options).disableSelection()


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

    @render_items()

    @enable_sorting() if @options.reorderable


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


