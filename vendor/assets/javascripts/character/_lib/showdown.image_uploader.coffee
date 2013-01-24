#
#  Image Uploader Extension
#  (image)  ->  <p><form ... /></p>
#

window.Showdown.extensions.imageuploader = (converter) ->
  [
    {
      type:   'lang',
      filter: (text) ->
        authenticity_token = workspace.authenticity_token()
        widget_html = """<p>
                           <form class='image-uploader' method=post action='/admin/character/images' enctype='multipart/form-data'>
                             <input name=_method type=hidden value=post>
                             <input name=authenticity_token type=hidden value="#{ authenticity_token }">
                             <input type=file id=image_uploader_input name='image' />
                             <button class='submit'>Upload</button>
                           </form>
                         </p>"""
        return text.replace(/\n\(image\)\n/g, widget_html)
    }
  ]

