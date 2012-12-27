#######################################
### CHARACTER :: Application Routes ###
#######################################

Router = Backbone.Router.extend
  routes:
    'new':          'newPost'
    'edit/:id':     'editPost'
    'preview/:id':  'showPostPreview'
    '':             'showIndex'

router = new Router

router.on 'route:newPost', ->
  window.app.show_editor()

router.on 'route:editPost', (id) ->
  window.app.show_editor(id)

router.on 'route:showPostPreview', (id) ->
  window.app.show_preview(id)

router.on 'route:showIndex', (id) ->
  if window.app.preview_view
    window.app.close_preview()
  else
    window.app.show_index()

window.router = router