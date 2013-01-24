class PagesIndexPage extends Backbone.View
  tagName: 'li'

  render: ->
    id        = @model.id
    title     = @model.get('title')
    permalink = @model.get('permalink')
    
    published_or_hidden = @model.state()
    
    img_tag = ''
    if @model.get('featured_image_id')
      img_tag = """<img class='featured' src='#{ @model.thumb_image_url() }' />"""

    html = """<a href='#/pages/edit/#{id}'>
                #{ img_tag }
                <div>
                  <strong>#{ title }</strong>
                  <span class='right'><small>#{ published_or_hidden }</small></span>
                </div>
                <div>
                  <small><em>#{ permalink }</em></small>
                </div>
              </a>"""
    $(this.el).html html
    $(this.el).attr('data-id', id)
    return this


  initialize: ->
    @listenTo(@model, 'destroy', @remove)


Character.Pages.Views.PagesIndexPage = PagesIndexPage

