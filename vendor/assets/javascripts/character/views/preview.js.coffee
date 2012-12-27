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
      # call to backend to remove the post
      #@model.destroy()
      window.posts.remove(@model)
      window.app.index_view.item_views[@model.id].remove()
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
                    <a href='#' title='Delete this post' class='foundicon-trash' id='delete_post'></a>
                    <span class='split'></span>
                    <a href='#/edit/#{id}' title='Edit this post' class='foundicon-edit'></a>
                    <span class='split'></span>
                    <a href='#/' title='Close Preview' class='foundicon-remove'></a>
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