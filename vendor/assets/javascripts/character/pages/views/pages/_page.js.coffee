class Page extends Character.Pages.Views.Base
  tagName: 'li'

  render: ->
    page            = @model.toJSON()
    id              = @model.id
    #views           = if page.published then page.views else ''
    published_or_hidden = @model.state()

    if page.featured_image_id
      img_tag = """<img class='featured' src='#{ @model.thumb_image_url() }' />"""
    else
      img_tag = """<i class='featured no-image general foundicon-photo'></i>"""

    html = """<a href='#/edit/#{id}'>
                #{img_tag}
                <div class='left'>
                  <span class='title'>#{page.title}</span>
                  <span class='meta'>#{page.permalink}</span>
                </div>
                <div class='right'>
                  <span class='meta2'>#{published_or_hidden}</span>
                </div>
              </a>"""
    $(this.el).html html
    $(this.el).attr('data-id', @model.id)
    return this


Character.Pages.Views.Pages.Page = Page

