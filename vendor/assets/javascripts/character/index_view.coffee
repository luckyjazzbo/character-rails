
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

  # @title
  # @scope
  # @reorderable
  # @model_slug

  render: ->
    html = Character.Templates.Index
      title:        @title
      new_item_url: "#/#{ @scope }/new"

    $(this.el).html html
    return this
  

  render_item: (obj) ->
    console.error 'IMPORTANT: "render_item" method is not implemented!'
    ""


  render_placeholder: ->
    html = """<li class=chr-placeholder>
                You don't have any posts yet, so go ahead and create the first one!
              </li>"""
    $(@items_el).append html


  render_items: ->
    objects = @items()

    (@render_placeholder() ; return) if objects.length == 0
    
    _(objects).each (obj) =>
      html = @render_item(obj)
      item = new Character.IndexItemView obj, html
      $(@items_el).append item.el


  items: ->
    console.error 'IMPORTANT: "items" method is not implemented!'
    []


  enable_sorting: ->
    options =
      stop: (e, ui) =>
        ids = this.$('li').map(-> $(this).attr('data-id')).get()        
        $.post "/admin/api/#{ @model_slug }/reorder", { _method: 'post', ids: ids }

    $(@items_el).sortable(options).disableSelection()


  initialize: (config) ->
    _.extend(@, config) if config

    html = @render().el
    $('#character').append(html)

    @panel_el = this.$('.chr-panel')
    @items_el = this.$('ul')

    @render_items()

    @enable_sorting() if @reorderable


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
    $(this.el).html @html
    $(this.el).attr('data-id', @model.id)
    return this


  initialize: (@model, @html)->
    @listenTo(@model, 'destroy', @remove)
    @render()


Character.IndexItemView = IndexItemView


