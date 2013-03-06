

#   ##     ##  #######  ########  ######## ##       
#   ###   ### ##     ## ##     ## ##       ##       
#   #### #### ##     ## ##     ## ##       ##       
#   ## ### ## ##     ## ##     ## ######   ##       
#   ##     ## ##     ## ##     ## ##       ##       
#   ##     ## ##     ## ##     ## ##       ##       
#   ##     ##  #######  ########  ######## ######## 




class Model extends Backbone.Model
  idAttribute:  '_id'


Character.Generic.Model = Model




#    ######   #######  ##       ##       ########  ######  ######## ####  #######  ##    ## 
#   ##    ## ##     ## ##       ##       ##       ##    ##    ##     ##  ##     ## ###   ## 
#   ##       ##     ## ##       ##       ##       ##          ##     ##  ##     ## ####  ## 
#   ##       ##     ## ##       ##       ######   ##          ##     ##  ##     ## ## ## ## 
#   ##       ##     ## ##       ##       ##       ##          ##     ##  ##     ## ##  #### 
#   ##    ## ##     ## ##       ##       ##       ##    ##    ##     ##  ##     ## ##   ### 
#    ######   #######  ######## ######## ########  ######     ##    ####  #######  ##    ## 




#class Collection extends Backbone.Paginator.requestPager #Backbone.Collection
class Collection extends Backbone.Collection
  model: Character.Generic.Model
  
  parse: (resp) ->
    @paginate = resp.paginate ? null
    resp.objects
  

  paginate_page: ->
    if @paginate and @paginate.page
      @paginate.page
    else
      1 # start with first page by default


  paginate_url: ->
    url     = @url
    params  = {}

    if @paginate and @paginate.per_page
      params = { per_page: @paginate.per_page, page: @paginate_page() }

    if @search_query and @search_query != ''
      params['q'] = @search_query

    if _.keys(params).length > 0
      url = url + "?" + _.map(params, (value, key) -> "#{ key }=#{ value }" ).join("&")

    return url


Character.Generic.Collection = Collection


