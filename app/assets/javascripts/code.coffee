###########################################################
# User: Tsukasa Arima (@pyar6329)
# Date: 15/06/24
# Time: 12:34
#
# Programingページの実装です
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
          class: "ui-widget-content",
          class_name: l.class_name,
          string: l.string
        ).text(l.name)

        # 使えるbuttonを追加
        abstract_syntax_lists.append(line)

      # Drag初期化
      $('#abstract_syntax_lists div').draggable({
        containment: "#input_code",
        snap: "#input_code",
        opacity: 0.4,
#        revert: true
        scroll: true,
        helper: "clone",
        start: (event, ui) ->
          console.log "start drag"
          $(ui.helper).text($(ui.helper).attr('string'))

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
          $(ui.helper).text($(ui.helper).attr('string'))
          clone_dragged = $(ui.draggable).clone()
          $(this).append(clone_dragged.text(clone_dragged.attr('string'))).removeClass()

      })

      # Sort初期化
      $('#input_code').sortable({
#        grid: [20, 10]
#        connectWith: ".connectedSortable"
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
