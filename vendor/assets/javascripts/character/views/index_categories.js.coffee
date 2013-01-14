class IndexCategoryItemView extends Backbone.View
  tagName: 'li'


  delete_category: (e) ->
    e.preventDefault()
    if confirm('Do you really want to remove this category?')
      window.app.index_view.categories.item_views[@model.id].remove()
      @model.destroy()


  events:
    'click .delete-category': 'delete_category'


  render: ->
    category = @model.toJSON()

    html = """<span class='category'>#{ category.title }</span>
              <a href='#/' title='Remove category' class='general foundicon-trash delete-category'></a>
              """
    $(this.el).html html
    return this


class IndexCategoriesView extends Backbone.View
  tagName:    'span'
  className:  'categories'
  id:         'categories'


  add_category: (e) ->
    e.preventDefault()
    title = window.prompt('Please enter category title:', '')

    if title
      check_title = window.categories.find (c) -> c.title == title

      if check_title
        alert 'Category with this title already exists. Please pick another title.'
      else
        new_category = window.categories.create({ title: title }, { wait: true })
        @render_item(new_category)


  initialize: ->
    html = @render().el
    $('#blog_index .buttons').append(html)

    @categories_btn = document.getElementById('categories_btn')

    @shown = false

    @list        = document.getElementById('categories_list')
    @item_views  = {}

    @render_items()


  render_item: (category) ->
    item = new IndexCategoryItemView model: category
    html = item.render().el
    $(@list).append html

    @item_views[category.id] = item


  render_items_placeholder: ->
    html = """<li class='placeholder'>No categories created yet.</li>"""
    $(@list).append html    


  render_items: ->
    categories = window.categories.toArray()

    if categories.length > 0
      @render_item(category) for category in categories
    else
      @render_items_placeholder()


  render: ->
    html = """<div class='categories-box'>
                <header>
                  <span>Categories</span>
                  <a href='#!' title='Create category' class='general foundicon-add-doc' id=add_category></a>
                </header>
                <ul id='categories_list'></ul>
              </div>
              <span class='split'></span>
              <a href='#/categories' title='Categories' class='general foundicon-folder' id=categories_btn></a>"""
    $(this.el).html html
    return this


  show_or_hide_categories_box: (e) ->
    e.preventDefault()
    if @shown
      $(@el).removeClass('shown')
      $(@categories_btn).removeClass('active')
      @shown = false
    else
      @shown = true
      $(@el).addClass('shown')
      $(@categories_btn).addClass('active')


  events:
    'click #add_category':    'add_category'
    'click #categories_btn':  'show_or_hide_categories_box'


window.IndexCategoriesView = IndexCategoriesView




