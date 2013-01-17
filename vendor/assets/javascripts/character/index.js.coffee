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


Character = {}


window.authenticity_token = ->
  $('meta[name=csrf-token]').attr('content')


$ ->
  Character.Blog.init() if $('.admin_character').length > 0

window.Character = Character

