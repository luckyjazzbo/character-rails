class PagesIndex extends Backbone.View
  tagName:  'div'
  id:       'pages'


  render_placeholder: ->
    html = """<li>
                <div class='alert-box empty-list-msg center-text'>
                  You don't have any pages yet, so go ahead and create the first one!
                </div>
              </li>"""
    $(@list).append html    


  render: ->
    html = """<div class='six columns left-column' id=index>
                <section class='chr-container'>
                  <header>
                    <strong>Pages</strong>
                    <span class='buttons'>
                      <a href='#/pages/new' title='Create new page' class='icon-btn general foundicon-add-doc'></a>
                    </span>
                  </header>
                  <ul id='list' class='items-list no-bullets'></ul>
                </section>
              </div>"""
    $(this.el).html html
    return this


  render_item: (page) ->
    item = new Character.Pages.Views.PagesIndexPage model: page
    html = item.render().el
    $(@list).append html

    @item_views[page.id] = item


  render_items: ->
    pages = window.pages.pages.toArray()

    if pages.length > 0
      @render_item(page) for page in pages
    else
      @render_placeholder()


  initialize: ->
    html = @render().el
    $('#app').append(html)

    @list        = document.getElementById('list')
    @item_views  = {}

    @render_items()

    sortable_options =
      stop: (e, ui) ->
        # we need to figure out the updated order of items
        params  =
          _method:            'put'
          ids:                $('#pages li').map(-> $(this).attr('data-id')).get()
          authenticity_token: workspace.authenticity_token()
        
        $.post Character.Pages.Pages.reorder_url(), params, (data) ->
          if data != "ok"
            alert 'Error happended. Please contact devs.'

    $(@list).sortable(sortable_options).disableSelection()


Character.Pages.Views.PagesIndex = PagesIndex





