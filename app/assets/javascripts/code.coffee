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
#          class_name: l.class_name,
#          class: "abstract_syntax",
          class: "ui-widget-content",
#          id: l.class_name,
          id: "draggable",
#          draggable: true,
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
        scroll: true
      })

      # Drag開始の処理
      $('#abstract_syntax_lists div').on('dragstart', (event, ui) ->
        console.log "start drag"
      )

      # Drag中の処理
      $('#abstract_syntax_lists div').on('drag', (event, ui) ->
        console.log "while drag"
      )

      # Drag終了の処理
      $('#abstract_syntax_lists div').on('dragstop', (event, ui) ->
        console.log "stop drag"
      )

    )

#    $('#abstract_syntax_lists div').draggable({
#      axis: "y"
#    })
#    console.log "hello"

#createProgram = ->
#  $ ->
#    $('#abstract_syntax_lists').children().draggable()
#    $('#Add').draggable()
#    program = $('#input_code')
#    program.append('ああああああ')

abstractSyntaxLists()
#createProgram()
