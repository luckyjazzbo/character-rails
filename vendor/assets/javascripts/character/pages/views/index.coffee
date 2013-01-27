class PagesIndex extends Character.IndexView
  title:          'Pages'
  new_item_url:   '#/pages/new'
  new_item_hint:  'Create new page'
  reorder_url:    '/admin/character/pages-reorder'


  render_item: (model) ->
    params =
      action_url:   "#/pages/edit/#{ model.id }"
      image_url:    model.thumb_image_url()
      line1_left:   model.get('menu_title')
      line1_right:  model.state()
      line2_left:   model.get('permalink')
      line2_right:  ''
    
    @default_item_template(params)


  items: ->
    window.pages.pages.toArray()


Character.Pages.Views.PagesIndex = PagesIndex





