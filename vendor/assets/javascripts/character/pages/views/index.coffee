class PagesIndex extends Character.IndexView
  title:          'Pages'
  new_item_url:   '#/pages/new'
  reorder_url:    '/admin/api/Character-Page/reorder'


  render_item: (model) ->
    Character.Templates.IndexItem
      action_url:   "#/pages/edit/#{ model.id }"
      image_url:    model.thumb_image_url()
      line1_left:   model.get('menu_title')
      line1_right:  model.state()
      line2_left:   model.get('permalink')
      line2_right:  ''


  items: ->
    window.pages.pages.toArray()


Character.Pages.Views.PagesIndex = PagesIndex





