class PagesIndex extends Character.IndexView
  title:          'Pages'
  new_item_url:   '#/pages/new'
  new_item_hint:  'Create new page'
  reorder_url:    '/admin/character/pages-reorder'

  render_item: (model) ->
    id              = model.id
    line1_left      = model.get('menu_title')
    line1_right     = model.state()
    line2_left      = model.get('permalink')
    line2_right     = ''
    thumb_image_url = model.thumb_image_url()
    img_tag         = if thumb_image_url then "<img src='#{ thumb_image_url }' />" else ''

    """ <a href='#/pages/edit/#{id}'>
          #{ img_tag }
          <div>
            <strong>#{ line1_left }</strong>
            <aside><small>#{ line1_right }</small></aside>
          </div>
          <div>
            <small><em>#{ line2_left }</em></small>
            <aside>#{ line2_right }</aside>
          </div>
        </a>"""    

  items: ->
    window.pages.pages.toArray()


Character.Pages.Views.PagesIndex = PagesIndex





