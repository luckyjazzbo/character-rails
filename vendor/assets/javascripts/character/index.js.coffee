#= require ../lodash
#= require ../underscore.string
#= require ../backbone
#= require ../replace_nth_occurrence
#= require ../showdown
#= require ../showdown.image_uploader
#= require ../showdown.github
#= require ../showdown.video
#= require ../jquery.smartresize

#= require codemirror
#= require codemirror/modes/javascript
#= require codemirror/modes/css
#= require codemirror/modes/xml
#= require codemirror/modes/htmlmixed
#= require codemirror/modes/markdown

#= require_self

#= require ./blog
#= require ./pages


window.Character = {}


window.authenticity_token = ->
  $('meta[name=csrf-token]').attr('content')


$ ->
  Character.Blog.init()  if $('.admin_character_blog').length > 0
  Character.Pages.init() if $('.admin_character_pages').length > 0

