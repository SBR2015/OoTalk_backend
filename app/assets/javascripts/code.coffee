# Author: Linh, Ounenhei, yuchan, Tsukasa Arima, Olivia

ootalk = require 'ootalk'

$ ->
  syntaxList = []
  getParameterByName = (name) ->
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]")
    regex = new RegExp("[\\?&]" + name + "=([^&#]*)")
    #url取得
    results = regex.exec(location.search)

    if results is null
      null
    else
      decodeURIComponent(results[1].replace(/\+/g, " "))

  syntaxHighlight = (json) ->
    json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    return json.replace /("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, (match) ->
      cls = 'number'
      if /^"/.test match
        if /:$/.test match
          cls = 'key'
        else
          cls = 'string'
      else if /true|false/.test match
        cls = 'boolean'
      else if /null/.test match
        cls = 'null'
      return '<span class="' + cls + '">' + match + '</span>'

  executeRequest = (params) ->
    $.ajax '/api/v1/execute',
      type:'POST'
      dataType:'json'
      data : params
      timeout: 10000
      success: (data) ->
        console.log data
#        $('#output_code').html syntaxHighlight JSON.stringify(data, undefined, 4)
        headline_text = '<table><thead><tr><th></td><th>実行文</th><th>実行結果</th></tr></thead><tbody></tbody></table>'
        $('#output_code').append(headline_text)
        for d, i in data
          line_text = '<tr><th>' + (i+1).toString() + '</th><td>' + d['exec'] + '</td><td>' + d['result'] + '</td></tr>'
          $('#output_code table tbody').append(line_text)
#          console.log line_text
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        alert(textStatus)

  # Drag初期化
  enDraggable = (obj) ->
    obj.draggable
      appendTo: "body"
      helper: "clone"
      start: (event, ui) ->
        console.log "start drag"
      drag: (event, ui) ->
#        console.log "while drag"
      stop: (event, ui) ->
#        console.log "stop drag"

  clone_dragged = (ui) ->
    clone_drag = $(ui.draggable).clone()
    clone_string = clone_drag.attr('string')
    this_string = clone_string
    if typeof clone_string isnt 'undefined' then clone_string else null

    # もう既に子がいればbreak
    return if this_string is null

    clone_drag.text('')

    for s in this_string.split('\t')
      child_line = $('<span></span>').text(s).attr('class_name', 'null')

      if s.charAt(0) is "@"
        $(child_line).attr('class_name', s.charAt(1).toUpperCase() + s.slice(2)).attr('id', "child-line")

        #コンスタントの処理
        if (ui.draggable.attr("class_name") is "Constant") or (ui.draggable.attr("class_name") is "Variable")
          consInput = $("<input placeholder='@value'>").css
            height: "25px"
            width: "70px"
            "background-color": "lightpink"
            color: "white"
          consInput.focus ->
            $(this).css
              "background-color": "#f5f5f5"
              color: "black"

          $(child_line).css(padding: "0px")
          $(child_line).text('').append(consInput)

          #各elemenの入れ子
        $(child_line).droppable if $(child_line).parent().attr('class_name') isnt 'Constant'
          tolerance: "pointer"
          #入れ子にelement一個しか入らない
          accept: ($element) ->
            return true if $(this).children().length < 1
          hoverClass: "ui-state-hover"
          drop: (event, ui) ->
#            if ui.draggable.parent().attr('id') is 'input_code'
#              $(ui.draggable).removeClass('ui-widget-content')
            $("#input_code").droppable('enable')
            $(this).append(clone_dragged(ui))

          #２度ドロップを防ぐ
          over: (event, ui) ->
            $("#input_code").droppable('disable')

        $(child_line).sortable
          connectWith: $('#input_code')
      $(clone_drag).append(child_line)
    return clone_drag

  initializeSyntaxList = (lang) ->
    URL = "/api/v1/abstractsyntax/"
    LANG = lang ? "ja"
    tree_code = {}
    $.get URL + LANG, null, (lists) =>
      abstract_syntax_lists = $("#abstract_syntax_lists")
      syntaxList = lists
      for l in lists
        line = $('<div></div>',
          class: "ui-widget-content" + " " + l.class_name
          class_name: l.class_name
          string: l.string).text(l.name)
        # 使えるbuttonを追加
        abstract_syntax_lists.append(line)

      enDraggable $('#abstract_syntax_lists div')

  createNode = (childnode, className, operand) ->
    hasClass = false
    if className is null
      return null

    if operand is 'Left' or operand is 'Right'
      hasClass = true
    else
      for list in syntaxList
        if list.class_name is className
          hasClass = true
          break

    if hasClass
      leftValue = null
      rightValue = null
      if ($(childnode).attr("class_name")) is 'Constant'
        leftValue = parseInt($($(childnode).find("input")[0]).val())
      else if ($(childnode).attr("class_name")) is 'Variable'
        leftValue = $($(childnode).find("input")[0]).val()
      else
        for n in $(childnode).children()
          if $(n).attr("class_name") is 'Left'
            for _n in $(n).children()
              leftValue = createNode(_n, $(_n).attr("class_name"), 'Left')
          else if $(n).attr("class_name") is 'Right'
            for _n in $(n).children()
              rightValue = createNode(_n, $(_n).attr("class_name"), 'Right')

      node = ootalk.newNode(className, leftValue, rightValue)
      return node

    return null

  createTreeNode = (parent, parentnodeid) ->
    children = parent.children()
    node = null
    for childnode in children
      className = $(childnode).attr "class_name"
      node = createNode childnode, className
      if node
        if parent.attr('id') is 'input_code'
          ootalk.append(node)
        createTreeNode($(childnode), node.nodeid);
      else
        createTreeNode($(childnode));

  lang = getParameterByName "lang"
  initializeSyntaxList(lang)

  # Drop初期化
  $('#input_code').droppable
    tolerance: "pointer"
    accept: ($element) ->
      return true if $element.parent().attr('id') is 'abstract_syntax_lists'
    drop: (event, ui) ->
      $(this).append(clone_dragged (ui))

  # Sort初期化
  $('#input_code').sortable
    connectWith: $('#child-line')

  #reset button
  $("input[type ='reset']").click ->
    $('#input_code').empty()

  #ゴミ箱
  $('#trash-can').droppable
    tolerance: "pointer"
    accept: ($element) ->
      return true if $element.parent().attr('id') isnt 'abstract_syntax_lists'
    hoverClass: ->
      $("#trash-o").fadeIn()
      $("#trash-c").hide()
      $(this).css
        width: "300px"
      $(this).append()
    out: (event, ui)->
      $(this).css
        width: "30px"
    drop: (event, ui) ->
      $(ui.draggable).remove()
      $("#trash-o").hide()
      $("#trash-c").fadeIn()
      $(this).animate({width: "30px"}, 1000)

  if $("#json_code").length == 1
    myCodeMirror = CodeMirror.fromTextArea $("#json_code")[0],
      mode:
        name:"javascript"
        json:true
      lineNumbers: true
      tabSize: 2

  $('#code_execute').submit (event) ->
    event.preventDefault()
    $('#output_code').text ""

    doc = myCodeMirror.getDoc()
    o = {}
    o["code[src]"] = doc.getValue()
    executeRequest(o)


  $('#ast_code_execute').submit (event) ->
    event.preventDefault()
    trees = []
    ootalk.init()
    createTreeNode($("#input_code"))
    console.log ootalk.tree()
    for elem in ootalk.tree()
      trees.push {"Program": elem}

    console.log JSON.stringify trees
    $('#output_code').text ""

    o = {}
    o["code[src]"] = JSON.stringify trees
    executeRequest(o)

  return
