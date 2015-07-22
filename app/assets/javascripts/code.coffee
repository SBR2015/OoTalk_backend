# Author: Linh, Ounenhei, yuchan, Tsukasa Arima

require 'ootalk'

$ ->
# Drag初期化
  enDraggable = (obj) ->
    obj.draggable
      appendTo: "body"
      cursor: "move"
      helper: "clone"

      start: (event, ui) ->
        console.log "start drag"
      drag: (event, ui) ->
        console.log "while drag"
      stop: (event, ui) ->
        console.log "stop drag"

  clone_dragged = (ui) ->
    clone_drag = $(ui.draggable).clone()
    clone_string = clone_drag.attr('string')
    this_string = if typeof clone_string isnt 'undefined' then clone_string else null

    # もう既に子がいればbreak
    return if this_string is null
    clone_drag.text('')

    for s in this_string.split('\t')
      child_line = $('<span></span>').text(s).attr('class_name', 'null')

      if s.charAt(0) is "@"
        $(child_line).attr('class_name', s.charAt(1).toUpperCase() + s.slice(2)).css
          padding: "0.5em"
          "background-color": "#d9534f"
          color: "#eee"
          display: "inline-block"

        #コンスタントの処理
        if ui.draggable.attr("class_name") is "Constant"
          consInput = $("<input placeholder='@value'>").css
            height: "25px"
            width: "80px"
            color: "black"
          $(child_line).css(padding: "0px")
          $(child_line).text('').append(consInput)

         #各elemenの入れ子
#        console.log $(child_line).parent().attr('class_name')
#        console.log $(child_line).attr('class_name')
        $(child_line).droppable if $(child_line).parent().attr('class_name') isnt 'Constant'
          #右サイドバーのボタンのみドロップ可
          accept: ($element) ->
            return true if $element.parent().attr('id') isnt 'input_code'
          hoverClass: "ui-state-hover"
          drop: (event, ui) ->
#            console.log $(this).parent().attr('class_name')
#            console.log $(this).attr('class_name')
            $(this).text('')
            $("#input_code").droppable('enable')
            $(this).droppable('disable')
            $(this).append(clone_dragged(ui))
          #２度ドロップを防ぐ
          over: (event, ui) ->
            $("#input_code").droppable('disable')

        enDraggable $(child_line)

      $(clone_drag).append(child_line)
    return clone_drag

  URL = "/api/v1/abstractsyntax/"
  LANG = "ja"
  tree_code = {}
  $.get URL + LANG, null, (lists) =>
    abstract_syntax_lists = $("#abstract_syntax_lists")

    for l in lists
      line = $('<div></div>',
        class: "ui-widget-content"
        class_name: l.class_name
        string: l.string).text(l.name)
      # 使えるbuttonを追加
      abstract_syntax_lists.append(line)

#    enDraggable $('#abstract_syntax_lists div')

  # Drop初期化
  $('#input_code').droppable
    drop: (event, ui) ->
      $(this).append(clone_dragged (ui))

  # Sort初期化
  $('#input_code').sortable
    stop: (event, ui) ->
      $('.ui-sortable-helper').remove()
  .disableSelection()
