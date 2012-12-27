
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
    date = @model?.get('date')
    html = """<div class='settings-box'>
                Date: <input id='date' type='date' value='#{date}'>
              </div>
              <button class='foundicon-settings' id='settings_btn'></button>"""
    $(this.el).html html
    return this


  date: ->
    $('#date').val()
  

  show_or_hide_settings_box: ->
    if @shown
      $(@el).removeClass('shown')
      @shown = false
    else
      @shown = true
      $(@el).addClass('shown')


  events:
    'click #settings_btn': 'show_or_hide_settings_box'


window.EditorSettingsView = EditorSettingsView
