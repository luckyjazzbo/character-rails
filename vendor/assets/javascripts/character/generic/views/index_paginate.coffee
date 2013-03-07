

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
    query = @options.collection().search_query
    url = "#/#{ @options.scope }"
    url += "/search/#{ query}" if query != ''
    url += "/p#{num}"
    return url


  render_prev: (current, pages) ->
    if current == 1
      path = @build_page_path(1)
      """<li class='arrow unavailable'><a href='#{ path }'><i class='icon-chevron-left'></i></a></li>"""
    else
      path = @build_page_path(current - 1)
      """<li class='arrow'><a href='#{ path }'><i class='icon-chevron-left'></i></a></li>"""


  render_next: (current, pages) ->
    if current == pages
      path = @build_page_path(pages)
      """<li class='arrow unavailable'><a href='#{ path }'><i class='icon-chevron-right'></i></a></li>"""
    else
      path = @build_page_path(current + 1)
      """<li class='arrow'><a href='#{ path }'><i class='icon-chevron-right'></i></a></li>"""


  render: ->
    collection = @options.collection()
    current = parseInt(collection.paginate.page)
    pages   = parseInt(collection.paginate.total_pages)

    if pages > 1

      page_links = ''
      _.each _.range(1, pages + 1), (i) =>
        current_cls = if i == current then 'current' else ''
        page_path   = @build_page_path(i)
        page_links += """<li class='#{ current_cls }'><a href='#{ page_path }'>#{ i }</a></li>"""

      prev_link = @render_prev(current, pages)
      next_link = @render_next(current, pages)

      html = """<ul class='pagination'>
                  #{ prev_link }
                  #{ page_links }
                  #{ next_link }
                </ul>"""

      @$el.html html


  initialize: ->
    $('#index_view .chr-index').after @el


Character.IndexPaginateView = IndexPaginateView




# DEMO:
# <li class="current"><a href="">1</a></li>
# <li><a href="">2</a></li>
# <li><a href="">3</a></li>
# <li><a href="">4</a></li>
# <li class="unavailable"><a href="">&hellip;</a></li>
# <li><a href="">12</a></li>
# <li><a href="">13</a></li>

