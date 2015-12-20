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
        headline_text = '<table class = "table table-hover"><thead><tr><th></td><th>' + I18n.t('Excute Code') + '</th><th>' + I18n.t('Excute Result') + '</th></tr></thead><tbody></tbody></table>'
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
        console.log "while drag"
      stop: (event, ui) ->
        console.log "stop drag"

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
        $(child_line).droppable
          tolerance: "pointer"
          #入れ子にelement一個しか入らない
          accept: ($element) ->
            return true if $(this).children().length < 1 && $element.parent().attr('id') is 'abstract_syntax_lists'
          hoverClass: "ui-state-hover"

          drop: (event, ui) ->
            $(this).append(clone_dragged(ui))
            $("#input_code").droppable('enable')

          #２度ドロップを防ぐ
          over: (event, ui) ->
            $("#input_code").droppable('disable')

        $(child_line).sortable
          connectWith: '#input_code'
      $(clone_drag).append(child_line)
    return clone_drag

  #syntax_listのアイコン
  syntax_icons = ['+', '−', '×', '÷', '%', 'log', 'aⁿ',
                  '&', '!&', 'ǀǀ', '!ǀǀ', '⊕',
                  '=', '≠','>', '≥', '<', '≤',
                  '→', '↻', 'if','a', '0']

  initializeSyntaxList = (lang) ->
    URL = "/api/v1/abstractsyntax/"
    LANG = lang ? "en"
    tree_code = {}
    $.get URL + LANG, null, (lists) =>
      abstract_syntax_lists = $("#abstract_syntax_lists")
      syntaxList = lists
      for l, i in lists
        line = $('<div></div>',
          class: "ui-widget-content" + " " + l.class_name
          id: "syntax"
          class_name: l.class_name
          string: l.string
          'data-toggle': 'popover'
          'data-trigger': 'hover'
          title: l.name
          'data-content': l.description).text(syntax_icons[i])

        # 使えるbuttonを追加
        abstract_syntax_lists.append(line)
      $('[data-toggle="popover"]').popover()
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
    connectWith: '#child-line'

  #reset button
  $("input[type ='reset']").click ->
    $('#input_code').empty()
    $('#output_code').empty()
    $('#input_code').droppable('enable')


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

  # I18n    
  $('#Reset').attr('value',I18n.t('Reset'))
  $('#Submit').attr('value',I18n.t('Submit'))
  $('#Code').text(I18n.t('Code'))
  $('#Input_JSON').text(I18n.t('Input JSON'))
  $('#Courses').text(I18n.t('Courses'))
  $('#Language').text(I18n.t('Language'))
  $('#Menu').text(I18n.t('Menu'))
  ########## Courseリストはここから ############

  get_courses = ->
    URL = '/api/v1/courses.json'
    $.get URL, null, (lists) =>
      all_lists = ''
      for l in lists
#        line = $('<div></div>', id: l.id).text(l.title)
#        line = '<div id="' + l.id + '">' + l.title + '</div>'
        all_lists += '<div id="' + l.id + '">' + '<i class="fa fa-book fa-5x"></i><br />' + l.title + '</div>'
      $('#course_list').empty().append(all_lists)
#      $('#course_list').replaceWith(all_lists)
    return

  get_lessons = (course_id) ->
    URL = '/api/v1/courses/' + course_id + '/lessons.json'
    $.get URL, null, (lists) =>
      all_lists = ''
      for l in lists
        all_lists += '<div id="' + l.id + '" course_id="' + l.course_id + '">' + l.title + '</div>'
      $('#lesson_list').empty().append(all_lists)
    return

  get_detail_lesson = (course_id, lesson_id) ->
    URL = '/api/v1/courses/' + course_id + '/lessons/' + lesson_id + '.json'
    console.log URL
    this_lesson = ''
    $.get URL, null, (lesson) =>
      this_lesson += '<div id="title"><h2>' + lesson.title + '</h2></div>'
      this_lesson += '<div id="line"></div>'
      this_lesson += '<p id="body" class="lead">' + lesson.body + '</p>'
      $('#lesson_detail').empty().append('<div id="' + lesson_id + '" course_id="' + course_id + '">' + this_lesson + '</div>')
    return

  show_courses = ->
    $('#course_list').show()
    $('#lesson_list').hide()
    $('#lesson_detail').hide()
    return

  show_lessons = ->
    $('#course_list').hide()
    $('#lesson_list').show()
    $('#lesson_detail').hide()
    return

  show_lesson_detail = ->
    $('#course_list').hide()
    $('#lesson_list').hide()
    $('#lesson_detail').show()
    return

  # Navigation var
  $('#subject').click (->
    $('#navbar_tail').slideToggle()
    show_courses()
    get_courses()
    $('.breadcrumb').empty().append('<li id="courses"><i class="fa fa-book"></i>Courses</li>')
    return
  )

  # breadcrumb courses
  $('.breadcrumb').on 'mouseenter mouseleave', '#courses', (->
    get_courses()
    show_courses()
    return
  )

  # breadcrumb lessons
  $('.breadcrumb').on 'mouseenter mouseleave', '#lessons', (->
#  $('#lessons').hover (->
#    lesson_id = $('#lesson_detail > div').attr('id')
#    course_id = $('#lesson_detail > div')#.attr('course_id')
#    console.log course_id
#    get_lessons(course_id)
    show_lessons()
    return
  )

  # course click
#  $('#course_list').on 'mouseenter mouseleave', 'div', ->
  $('#course_list').on 'click', 'div', ->
    get_lessons(this.id)
    show_lessons()
    $('.breadcrumb').empty().append('<li id="courses"><i class="fa fa-book"></i>Courses</li><li id="lessons"><i class="fa fa-file-text-o"></i>Lessons</li>')
    return
#  )

  $('#lesson_list').on 'click', 'div', ->
#    console.log $(this).attr('course_id')
    get_detail_lesson($(this).attr('course_id'), $(this).attr('id'))
    show_lesson_detail()
#    $('.breadcrumb').empty().append('<li id="courses">Courses</li><li id="lessons">Lessons</li>')
    return

  ######## courseリストここまで ################


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
