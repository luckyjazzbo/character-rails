class PagesIndex extends Character.IndexView
  title:        'Pages'
  scope:        'pages'
  reorderable:  true
  model_slug:   'Character-Page'


  render_item: (model) ->
    Character.Templates.IndexItem
      action_url:   "#/#{ @scope }/edit/#{ model.id }"
      image_url:    model.thumb_image_url()
      line1_left:   model.get('menu_title')
      line1_right:  model.state()
      line2_left:   model.get('permalink')
      line2_right:  ''


  items: ->
    window.pages.pages.toArray()


Character.Pages.Views.PagesIndex = PagesIndex





