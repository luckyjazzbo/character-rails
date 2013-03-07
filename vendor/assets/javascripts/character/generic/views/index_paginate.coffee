

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
      prev_visibility = if current != 1 then '' else 'unavailable'
      prev_page_path  = @build_page_path(current - 1)
      next_visibility = if current != pages then '' else 'unavailable'
      next_page_path  = @build_page_path(current + 1)

      page_links = ''
      _.each _.range(1, pages + 1), (i) =>
        current_cls = if i == current then 'current' else ''
        page_path   = @build_page_path(i)
        page_links += """<li class='#{ current_cls }'><a href='#{ page_path }'>#{ i }</a></li>"""

      # <li class="current"><a href="">1</a></li>
      # <li><a href="">2</a></li>
      # <li><a href="">3</a></li>
      # <li><a href="">4</a></li>
      # <li class="unavailable"><a href="">&hellip;</a></li>
      # <li><a href="">12</a></li>
      # <li><a href="">13</a></li>


      html = """<ul class='pagination'>
                  <li class='arrow #{ prev_visibility }'>
                    <a href='#{ prev_page_path }'><i class='icon-chevron-left'></i></a>
                  </li>

                  #{ page_links }

                  <li class='arrow #{ next_visibility }'>
                    <a href='#{ next_page_path }'><i class='icon-chevron-right'></i></a>
                  </li>
                </ul>"""

      @$el.html html


  initialize: ->
    $('#index_view .chr-index').after @el


Character.IndexPaginateView = IndexPaginateView





