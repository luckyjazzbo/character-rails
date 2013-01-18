class List extends Character.Pages.Views.Base
  tagName:    'div'
  className:  'chr-panel left index'
  id:         'pages_index'


  render: ->
    html = """<section class='container'>
                <header>
                  <span class='title'>Pages</span>
                  <span class='buttons'>
                    <a href='#/new' title='Create new page' class='general foundicon-add-doc'></a>
                  </span>
                </header>
                <ul id='list' class='pages-index'></ul>
              </section>"""
    $(this.el).html html
    return this


  render_item: (page) ->
    item = new Character.Pages.Views.Pages.Page model: page
    html = item.render().el
    $(@list).append html

    @item_views[page.id] = item


  render_items_placeholder: ->
    html = """<li class='placeholder'>Hey there! You don't have any pages yet, so go ahead and create the first one!</li>"""
    $(@list).append html    


  render_items: ->
    pages = @pages().toArray()

    if pages.length > 0
      @render_item(page) for page in pages
    else
      @render_items_placeholder()


  initialize: ->
    html = @render().el
    $('#main').append(html)

    @list        = document.getElementById('list')
    @item_views  = {}

    @render_items()

    sortable_options =
      stop: (e, ui) ->
        # we need to figure out the updated order of items
        ids     = $('#pages_index li').map(-> $(this).attr('data-id')).get()

        params  =
          ids:                ids
          _method:            'put'
          authenticity_token: window.authenticity_token()
        
        $.post Character.Pages.Pages.reorder_url(), params, (data) ->
          if data != "ok"
            alert 'Error happended. Please contact devs.'

    $(@list).sortable(sortable_options).disableSelection()


Character.Pages.Views.Pages.List = List





