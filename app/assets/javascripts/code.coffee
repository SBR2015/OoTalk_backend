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
#        console.log(line)
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
#          $(ui.draggable).clone().appendTo(this)
#          $(ui.draggable).remove()
#          $(this).append($(ui.helper).clone())
#          if $(ui.draggable).find('#abstract_syntax_lists div').length == 0
#            $(this).draggable().append($(ui.helper).clone())
      })

      # Drop初期化
      $('#input_code').droppable({
        drop: (event, ui) ->
          console.log "drop"
          $(ui.helper).text($(ui.helper).attr('string'))
          clone_dragged = $(ui.draggable).clone()
          $(this).append(clone_dragged.text(clone_dragged.attr('string'))).removeClass()

#          console.log "this = " + clone_dragged.attr('string')

#          $(hoge).text($(hoge).attr('string'))
#          $(hoge).text($(ui.helper).attr('string'))
#          $(ui.helper).disableSelection()
#          $(this).attr('class_name')
#          $(this).remove()
      })

      # Sort初期化
      $('#input_code').sortable({
#        grid: [20, 10]
#        connectWith: ".connectedSortable"
        stop: (event, ui) ->
          $(ui.helper).remove()
      }).disableSelection()

#      $("#abstract_syntax_lists div").live('dblclick', ->
#        $(this).remove()
#      )
      # Drag開始の処理
#      $('#abstract_syntax_lists div').on('dragstart', (event, ui) ->
#        console.log "start drag"
#        offset = $(this).offset()
#        xPos = offset.left
#        yPos = offset.top
#        console.log "x = " + xPos + " y = " + yPos
#        ui.clone.appendTo(this)
#      )

      # Drag中の処理
#      $('#abstract_syntax_lists div').on('drag', (event, ui) ->
#        console.log "while drag"
#      )

      # Drag終了の処理
#      $('#abstract_syntax_lists div').on('dragstop', (event, ui) ->
#        $(this).append($(ui.helper).clone())
#      )

    )


#createProgram = ->
#  $ ->
#    $('#abstract_syntax_lists').children().draggable()
#    $('#Add').draggable()
#    program = $('#input_code')
#    program.append('ああああああ')

abstractSyntaxLists()
#createProgram()
