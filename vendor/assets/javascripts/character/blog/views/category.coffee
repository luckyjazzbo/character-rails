class BlogCategory extends Backbone.View
  tagName: 'li'


  delete_category: (e) ->
    e.preventDefault()
    if confirm('Do you really want to remove this category?')
      @app().index_view.categories.item_views[@model.id].remove()
      @model.destroy()


  events:
    'click .delete-category': 'delete_category'


  render: ->
    category = @model.toJSON()

    html = """<span class='category'>#{ category.title }</span>
              <a href='#/' title='Remove category' class='general foundicon-trash delete-category'></a>
              """
    $(this.el).html html
    $(this.el).attr('data-id', @model.id)
    return this


Character.Blog.Views.BlogCategory = BlogCategory

