class BlogIndexShow extends Backbone.View
  tagName:    'div'
  className:  'six columns right-column'
  id:         'preview'


  render: ->
    post  = @model.toJSON()
    state = @model.state()
    id    = @model.id

    html = """<div class='chr-container'>
                <header>
                  <strong>#{state}</strong>
                  <span class='buttons'>
                    <a href='#' title='Delete this post' class='icon-btn general foundicon-trash' id='delete_post'></a>
                    <span class='split'></span>
                    <a href='#/blog/edit/#{id}' title='Edit this post' class='icon-btn general foundicon-edit'></a>
                    <span class='split'></span>
                    <a href='#/blog' title='Close Preview' class='icon-btn general foundicon-remove'></a>
                  </span>
                </header>

                <article class='item-preview'>
                  #{post.html}
                </article>
              </div>"""
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

