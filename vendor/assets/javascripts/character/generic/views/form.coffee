

#    ########  #######  ########  ##     ## 
#    ##       ##     ## ##     ## ###   ### 
#    ##       ##     ## ##     ## #### #### 
#    ######   ##     ## ########  ## ### ## 
#    ##       ##     ## ##   ##   ##     ## 
#    ##       ##     ## ##    ##  ##     ## 
#    ##        #######  ##     ## ##     ## 


class FormView extends Backbone.View
  tagName:    'div'


  render: (form_html)->
    actions = ""

    if @model
      actions += """<a href='#' title='Delete this document' class='general foundicon-trash' id=delete></a>"""
    actions   += """<a href='#' title='Close form' class='general foundicon-remove' id=close></a>"""

    html = Character.Templates.Panel 
      classes:  'right'
      title:    if @model then "Edit" else "New"
      actions:  actions
      content:  """<section class='chr-edit chr-form'>#{ form_html }</section>"""

    $(this.el).html html
    return this


  update_or_create: (obj) ->
    if typeof(obj) == "string"
      @render(obj)
    else
      if @model then @model.set(obj) else @options.collection().add(obj)
      @close()
      @back_to_index()


  initialize: (config, parent_el, form_html) ->
    _.extend(@, config) if config

    html = @render(form_html).el
    $(parent_el).append(html)

    $('.chr-form form').ajaxForm
      success: (obj) => @update_or_create(obj) #if @model then @update_model(obj) else @create_model(obj)

    @listenTo(@model, 'destroy', @remove) if @model


  delete: (e) ->
    e.preventDefault()
    if confirm('Do you really want to remove this document?')
      @model.destroy()
      workspace.router.navigate("#/#{ @options.scope }", { trigger: true })      


  close: (e) ->
    e.preventDefault() if e
    workspace.current_view.unlock_scroll()
    
    @back_to_index()
    @remove()

    workspace.current_view.unset_active()
    workspace.current_view.flush_scroll_y()



  back_to_index: ->
    workspace.router.navigate("#/#{ @scope }", { trigger: false })


  events:
    'click #delete': 'delete'
    'click #close':  'close'


Character.FormView = FormView
