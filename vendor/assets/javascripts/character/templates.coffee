Templates = 
  Panel: (params) ->
    # --------------------------
    # params =
    #   classes
    #   title
    #   actions  
    #   content
    # --------------------------
    """ <div class='chr-panel #{ params.classes }'>
          <section>
            <header>
              <strong>#{ params.title }</strong>
              <aside>
                #{ params.actions }
              </aside>
            </header>
            #{ params.content }
          </section>
        </div>"""


  Index: (params) ->
    # --------------------------
    # params =
    #   title
    #   new_item_link
    # --------------------------
    actions = ''
    
    if params.new_item_url
      actions += "<a href='#{ params.new_item_url }' title='Create new' class='general foundicon-add-doc'></a>"
    
    Character.Templates.Panel
      classes: 'left'
      title:   params.title
      actions: actions
      content: """<ul class='chr-index'></ul>"""


  IndexItem: (params) ->
    # --------------------------
    # params =
    #   action_url
    #   image_url
    #   line1_left, line1_right
    #   line2_left, line2_right
    # --------------------------
    image = if params.image_url then "<img src='#{ params.image_url }' />" else ''

    """ <a href='#{ params.action_url }'>
          #{ image }
          <div>
            <strong>#{ params.line1_left }</strong>
            <aside><small>#{ params.line1_right }</small></aside>
          </div>
          <div>
            <small><em>#{ params.line2_left }</em></small>
            <aside>#{ params.line2_right }</aside>
          </div>
        </a>"""  


Character.Templates = Templates

