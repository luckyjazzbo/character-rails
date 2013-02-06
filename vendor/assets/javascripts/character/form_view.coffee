class FormView extends Backbone.View
  tagName:    'div'

  # @scope

  render: (form_html)->
    actions = ""

    if @model
      actions += """<a href='#' title='Delete this document' class='general foundicon-trash' id=delete></a>"""
    actions += """<a href='#/#{ @scope }' title='Close form' class='general foundicon-remove'></a>"""

    html = Character.Templates.Panel 
      classes:  'right'
      title:    "TITLE" #@model.state()
      actions:  actions
      content:  """<section class='chr-edit chr-form'>#{ form_html }</section>"""

    $(this.el).html html
    return this


  back_to_index: ->
    workspace.router.navigate("#/#{ @scope }", { trigger: true })


  create_model: (obj) ->
    @collection().add(obj)
    @back_to_index()
  

  update_model: ->
    @model.fetch { success: => @back_to_index() }


  initialize: (config, parent_el, form_html) ->
    _.extend(@, config) if config

    html = @render(form_html).el
    $(parent_el).append(html)

    $('.chr-form form').ajaxForm
      success: (obj) => if @model then @update_model() else @create_model(obj)

    @listenTo(@model, 'destroy', @remove) if @model


  delete: (e) ->
    e.preventDefault()
    if confirm('Do you really want to remove this document?')
      @model.destroy()
      workspace.router.navigate('#/', { trigger: true })      


  events:
    'click #delete': 'delete'


Character.FormView = FormView
