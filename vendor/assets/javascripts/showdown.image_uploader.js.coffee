#
#  Images Uploader Extension
#  (image)  ->  <p><a class='upload-image'>Upload image</a></p>
#

window.Showdown.extensions.imageuploader = (converter) ->
  console.log 'test'
  [
    {
      # image uploader
      type:   'lang',
      filter: (text) ->
        return text.replace(/\n\(image\)\n/g, """<p><a class='image-uploader general foundicon-photo' href='#'>Upload image</a></p>""")
    }
  ]

