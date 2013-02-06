class BlogIndexShow extends Backbone.View
  tagName:    'div'


  render: ->
    id    = @model.id
    html  = @model.get('html')

    html = Character.Templates.Panel 
      classes:  'right'
      title:    @model.get('state')
      actions:  """<a href='#' title='Delete this post' class='general foundicon-trash' id='delete_post'></a>
                   <a href='#/blog/edit/#{ id }' title='Edit post' class='general foundicon-edit'></a>
                    <a href='#/blog' title='Close Preview' class='general foundicon-remove'></a>"""
      content:  """<article class='chr-blog-post-preview' id=preview>#{ html }</article>"""

    $(this.el).html html
    return this


  initialize: ->
    @listenTo(@model, 'destroy', @remove)


  delete_post: (e) ->
    e.preventDefault()
    if confirm('Do you really want to remove this post?')
      @model.destroy()
      workspace.router.navigate('#/', {trigger: true})      


  events:
    'click #delete_post': 'delete_post'


Character.Blog.Views.BlogIndexShow = BlogIndexShow

