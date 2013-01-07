####################################
### CHARACTER :: PostPreviewView ###
####################################

class PostPreviewView extends Backbone.View
  tagName:    'div'
  className:  'chr-panel right quickview'
  id:         'blog_quickview'


  delete_post: (e) ->
    e.preventDefault()
    if confirm('Do you really want to remove this post?')
      # this event could be probably tighted to collection event or model destory event
      window.app.index_view.item_views[@model.id].remove()
      @model.destroy()
      router.navigate('#/', {trigger: true})      


  events:
    'click #delete_post': 'delete_post'

  render: ->
    post  = @model.toJSON()
    state = @model.state()
    id    = @model.id

    html = """<section class='container'>
                <header>
                  <span class='title'>#{state}</span>
                  <span class='buttons'>
                    <a href='#' title='Delete this post' class='general foundicon-trash' id='delete_post'></a>
                    <span class='split'></span>
                    <a href='#/edit/#{id}' title='Edit this post' class='general foundicon-edit'></a>
                    <span class='split'></span>
                    <a href='#/' title='Close Preview' class='general foundicon-remove'></a>
                  </span>
                </header>

                <article>
                  <section class='content'>
                    #{post.html}
                  </section>
                </article>
              </section>"""
    $(this.el).html html
    return this

window.PostPreviewView = PostPreviewView