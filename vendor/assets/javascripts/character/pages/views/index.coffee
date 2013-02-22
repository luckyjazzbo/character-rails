class PagesIndex extends Character.IndexView
  options:
    title:        'Pages'
    scope:        'pages'
    reorderable:  true
    model_slug:   'Character-Page'

    render_item_options:
      image_url:    'thumb_image_url'
      line1_left:   'menu_title'
      line1_right:  'state'
      line2_left:   'permalink'

    items: -> window.pages.pages.toArray()


Character.Pages.Views.PagesIndex = PagesIndex

