

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

  render: ->
    collection = @options.collection()
    current = collection.paginate.page
    pages   = collection.paginate.total_pages

    if pages > 1
      html = """<em>#{ current } of #{ pages }</em>
                <a href='#' id=paginate_prev class=chr-left><i class='icon-chevron-left'></i></a>
                <a href='#' id=paginate_prev class=chr-right><i class='icon-chevron-right'></i></a>"""
      @$el.html html

  initialize: ->
    $('#index_view .chr-index').after @el


Character.IndexPaginateView = IndexPaginateView