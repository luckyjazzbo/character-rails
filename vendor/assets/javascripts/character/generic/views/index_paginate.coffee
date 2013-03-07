

#    ########     ###     ######   #### ##    ##    ###    ######## ######## 
#    ##     ##   ## ##   ##    ##   ##  ###   ##   ## ##      ##    ##       
#    ##     ##  ##   ##  ##         ##  ####  ##  ##   ##     ##    ##       
#    ########  ##     ## ##   ####  ##  ## ## ## ##     ##    ##    ######   
#    ##        ######### ##    ##   ##  ##  #### #########    ##    ##       
#    ##        ##     ## ##    ##   ##  ##   ### ##     ##    ##    ##       
#    ##        ##     ##  ######   #### ##    ## ##     ##    ##    ######## 


class IndexPaginateView extends Backbone.View
  tagName:    'div'
  className:  'chr-paginate'
  id:         'index_paginate'


  build_page_path: (num) ->
    url = "#/#{ @options.scope }"
    url += "/search/#{ @options.search_query}" if @options.search_query != ''
    url += "/p#{num}"
    return url


  render: ->
    collection = @options.collection()
    current = parseInt(collection.paginate.page)
    pages   = parseInt(collection.paginate.total_pages)

    if pages > 1
      html = """<em>#{ current } of #{ pages }</em>"""

      if current != 1
        prev_page_path = @build_page_path(current - 1)
        html += "<a href='#{ prev_page_path }' id=paginate_prev class=chr-left><i class='icon-chevron-left'></i></a>"

      if current != pages
        next_page_path = @build_page_path(current + 1)
        html += "<a href='#{ next_page_path }' id=paginate_next class=chr-right><i class='icon-chevron-right'></i></a>"

      @$el.html html


  initialize: ->
    $('#index_view .chr-index').after @el


Character.IndexPaginateView = IndexPaginateView