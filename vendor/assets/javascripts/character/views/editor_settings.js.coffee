
class EditorSettingsView extends Backbone.View
  tagName:    'div'
  className:  'settings'
  id:         'settings'


  initialize: ->
    html = @render().el
    $('footer').append(html)

    @settings_btn = document.getElementById('settings_btn')

    @shown = false


  render: ->
    date    = @model?.get('date')
    excerpt = @model?.get('excerpt') ? ''
    tags    = @model?.get('tags')    ? ''

    post_category     = @model?.category()
    category_options  = '<option>No set</option>'
    
    window.categories.each (c) ->
      if post_category and post_category.id == c.id
        category_options += """<option value='#{c.id}' selected>#{c.get('title')}</option>"""
      else
        category_options += """<option value='#{c.id}'>#{c.get('title')}</option>"""

    html = """<div class='settings-box'>
                <i class='general foundicon-calendar'></i> <input id=date type=date value='#{date}' class=date>
                <label>Excerpt:</label>
                <textarea id=excerpt class=excerpt rows=5>#{excerpt}</textarea>
                <label>Tags splitted with comma:</label>
                <input type=text id=tags class=tags value='#{tags}'/>
                <label>Pick a category for this post:</label>
                <select id=category_id class=categories>
                  #{category_options}
                </select>
              </div>
              <button class='general foundicon-settings' id=settings_btn></button>"""
    $(this.el).html html
    return this


  date: ->
    $('#date').val()
  
  excerpt: ->
    $('#excerpt').val()

  tags: ->
    $('#tags').val()

  show_or_hide_settings_box: ->
    if @shown
      $(@el).removeClass('shown')
      @shown = false
    else
      @shown = true
      $(@el).addClass('shown')

  category_id: ->
    $('#category_id').val()

  events:
    'click #settings_btn': 'show_or_hide_settings_box'


window.EditorSettingsView = EditorSettingsView




