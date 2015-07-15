###########################################################
# User: Linh, Ounenhei
#
# 有馬さんが書いたコードを一応いじりました
# ---------------------使い方------------------
# まだ終わってない…
###############################################

abstractSyntaxLists = ->
  URL = "/api/v1/abstractsyntax/"
  LANG = "ja"
  tree_code = {}
  #  ARGUMENTS = {
  #    "@left": "Left",
  #    "@right": "Right",
  #    "@middle": "Middle"
  #  }

  $ ->
    $.get(URL + LANG, null, (lists) =>
      abstract_syntax_lists = $("#abstract_syntax_lists")

      for l in lists
        line = $('<div></div>',
#          id: l.id,
#          id: "code",
          class: "ui-widget-content",
          class_name: l.class_name,
          string: l.string
        ).text(l.name)

        # 使えるbuttonを追加
        abstract_syntax_lists.append(line)

      # Drag初期化
      $('#abstract_syntax_lists div').draggable({
#        containment: "#input_code",
#        snap: "#input_code",
#        opacity: 0.4,
#        revert: true
#        scroll: true,
        appendTo: "body",
        cursor: "move",
        helper: "clone",
        start: (event, ui) ->
          console.log "start drag"
#          $(ui.helper).text($(ui.helper).attr('string')).css(
#            'width': '350px'
#          )

#          offset = $(this).offset()
#          xPos = offset.left
#          yPos = offset.top
#          console.log "x = " + xPos + " y = " + yPos

        drag: (event, ui) ->
          console.log "while drag"

        stop: (event, ui) ->
          console.log "stop drag"

      })

      # Drop初期化
      $('#input_code').droppable({
        drop: (event, ui) ->
          console.log "drop"
          clone_dragged = $(ui.draggable).clone()
          clone_string = clone_dragged.attr('string')
          this_string = if typeof clone_string isnt 'undefined' then clone_string else null

          # もう既に子がいればbreak
          return if this_string is null
          clone_dragged.text('')

          for s in this_string.split('\t')
            child_line = $('<span></span>').text(s).attr('class_name', 'null')
            if s.charAt(0) is "@"
              $(child_line).attr('class_name', s.charAt(1).toUpperCase() + s.slice(2))
              .css(
#                "height": "50px",
#                "width": "10px",
                "padding": "0.5em",
#                "text-align": "center",
#                "font-size": "12px",
#                "border": "1px solid black",
                "background-color": "#d9534f",
                "color": "#eee"
              )
              #各elemenの入れ子
              $(child_line).droppable({
                hoverClass: "ui-state-hover"
                drop: (event, ui) ->
#                  console.log ui.draggable.parent().attr('id')
#                  console.log ui.draggable.parent()
                  if ui.draggable.parent().attr('id') is "input_code"
                    ui.draggable.remove()

                  if ui.draggable.attr("class_name") is "Constant"
                    $consText = $("<textarea placeholder='@value'>").css(
                      "height": "25px",
                      "width": "80px",
                      "color": "black"
                    )
                    console.log("drop" + $(this).attr("class_name"))
                    $(this).text('').append($consText)
                  else
                    console.log("drop" + $(this).attr("class_name"))
                    $(this).text(ui.draggable.attr("string"))
#                  if ui.draggble.parent().attr("id") == "input_code"
#                    ui.draggable.remove()
                  $("#input_code").droppable('enable')
                over: (event, ui) ->
                  $("#input_code").droppable('disable')
              })


            $(clone_dragged).append(child_line)
          $(this).append(clone_dragged).removeClass()

      })

      # Sort初期化
      $('#input_code').sortable({
#        grid: [20, 10]
#        connectWith: "#code"
#        greedy: true,
#        handle: 'div',
#        items: 'div',
#        toleranceElement: '> div'#,
#        tolerance: 'pointer',
#        revert: 'invalid',
#        placeholder: 'span2 well placeholder tile',
#        forceHelperSize: true,
        stop: (event, ui) ->
          $('.ui-sortable-helper').remove()

      }).disableSelection()

    )


    # submitボタンを押した時、tree構造のjsonを生成
    #createProgram = ->
    #  $ ->
    # プログラミングのjson生成
    this_code = $('#input_code')
#    this_class_name = .attr('class_name')
#    this_string = $(ui.helper).attr('string').split('\t')

#    tree_code[this_class_name] = this_string
#    console.log "class name = " + this_class_name
#    console.log "string = " + this_string
#    console.log tree_code

abstractSyntaxLists()
#createProgram()
