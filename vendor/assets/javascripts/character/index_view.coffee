class IndexView extends Backbone.View
  tagName:    'div'
  id:         'index_view'

  render: ->
    title         = @title
    new_item_link = if @new_item_url then "<a href='#{ @new_item_url }'
                                              title='#{ @new_item_hint }'
                                              class='general foundicon-add-doc'></a>" else ''
    html = """<div class='chr-panel left'>
                <section>
                  <header>
                    <strong>#{ title }</strong>
                    <aside>
                      #{ new_item_link }
                    </aside>
                  </header>
                  <ul class='chr-index'></ul>
                </section>
              </div>"""
    $(this.el).html html
    return this


  default_item_template: (params) ->
    image = if params.image_url then "<img src='#{ params.image_url }' />" else ''

    """ <a href='#{ params.action_url }'>
          #{ image }
          <div>
            <strong>#{ params.line1_left }</strong>
            <aside><small>#{ params.line1_right }</small></aside>
          </div>
          <div>
            <small><em>#{ params.line2_left }</em></small>
            <aside>#{ params.line2_right }</aside>
          </div>
        </a>"""    
  

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
        $.post @reorder_url, { _method: 'put', ids: ids }

    $(@items_el).sortable(options).disableSelection()


  initialize: ->
    html = @render().el
    $('#character').append(html)

    @panel_el = this.$('.chr-panel')
    @items_el = this.$('ul')

    @render_items()

    @enable_sorting() if @reorder_url


Character.IndexView = IndexView



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


