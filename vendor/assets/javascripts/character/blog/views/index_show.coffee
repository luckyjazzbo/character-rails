class BlogIndexShow extends Backbone.View
  tagName:    'div'
  className:  'chr-panel right'


  render: ->
    post  = @model.toJSON()
    state = @model.state()
    id    = @model.id

    html = """<section>
                <header>
                  <strong>#{state}</strong>
                  <aside>
                    <a href='#' title='Delete this post' class='general foundicon-trash' id='delete_post'></a>
                    <a href='#/blog/edit/#{id}' title='Edit this post' class='general foundicon-edit'></a>
                    <a href='#/blog' title='Close Preview' class='general foundicon-remove'></a>
                  </aside>
                </header>

                <article class='chr-blog-post-preview' id=preview>
                  #{post.html}
                </article>
              </section>"""
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

