



#    #### ######## ######## ##     ## 
#     ##     ##    ##       ###   ### 
#     ##     ##    ##       #### #### 
#     ##     ##    ######   ## ### ## 
#     ##     ##    ##       ##     ## 
#     ##     ##    ##       ##     ## 
#    ####    ##    ######## ##     ## 




class IndexItemView extends Backbone.View
  tagName: 'li'


  render: =>
    action_name = @options.render_item_options.action_name ? 'edit'
    config      = { action_url: "#/#{ @options.scope }/#{ action_name }/#{ @model.id }" }
    
    _.each @options.render_item_options, (val, key) => config[key] = @model.get(val)
    
    html = Character.Templates.IndexItem(config)

    @$el.html html
    @$el.attr('data-id', @model.id)
    return this


  initialize: ->
    @listenTo(@model, 'change',  @render)
    @listenTo(@model, 'destroy', @remove)
    @render()


Character.IndexItemView = IndexItemView



