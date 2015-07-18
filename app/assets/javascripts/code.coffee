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

    enDraggable $('#abstract_syntax_lists div')

  # Drop初期化
  $('#input_code').droppable
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
          $(child_line).attr('class_name', s.charAt(1).toUpperCase() + s.slice(2)).css
            padding: "0.5em"
            "background-color": "#d9534f"
            color: "#eee"

          #各elemenの入れ子
          $(child_line).droppable
            hoverClass: "ui-state-hover"
            drop: (event, ui) ->
              if ui.draggable.parent().attr('id') is "input_code"
                ui.draggable.remove()

              if ui.draggable.attr("class_name") is "Constant"
                $consText = $("<textarea placeholder='@value'>").css
                  height: "25px"
                  width: "80px"
                  color: "black"

                console.log "drop" + $(this).attr("class_name")
                $(this).text('').append($consText)
              else
                console.log "drop" + $(this).attr("class_name")
                $(this).text ui.draggable.attr("string")
                $("#input_code").droppable 'enable'
            over: (event, ui) ->
              $("#input_code").droppable('disable')
          enDraggable $(child_line)
        else

        $(clone_dragged).append(child_line)
      $(this).append(clone_dragged).removeClass()

  # Sort初期化
  $('#input_code').sortable
    stop: (event, ui) ->
      $('.ui-sortable-helper').remove()
  .disableSelection()
