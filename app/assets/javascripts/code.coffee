$ ->
    sitei18n.init()
    
    # Drop初期化
    $('#input_code').droppable
        tolerance: "pointer"
        accept: ($element) ->
            return true if $element.parent().attr('id') is 'abstract_syntax_lists'
        drop: (event, ui) ->
            $(this).append(codeui.clone_dragged (ui))
            return

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
        codeutil.executeRequest(o)

    $('#ast_code_execute').submit (event) ->
        event.preventDefault()
        trees = []
        codeui.initNode()
        codeui.createTreeNode($("#input_code"))
        console.log codeui.treeNode() 
        for elem in codeui.treeNode()
            trees.push {"Program": elem}

        console.log JSON.stringify trees
        $('#output_code').text ""

        o = {}
        o["code[src]"] = JSON.stringify trees
        codeutil.executeRequest(o)

    # Navigation var
    $('#subject').click ( ->
        $('#navbar_tail').slideToggle()
        course.show_courses()
        course.get_courses()
        $('.breadcrumb').empty().append('<li id="courses"><i class="fa fa-book"></i>Courses</li>')
        )

    # breadcrumb courses
    $('.breadcrumb').on 'mouseenter mouseleave', '#courses', ( ->
        course.get_courses()
        course.show_courses()
        )

    # breadcrumb lessons
    $('.breadcrumb').on 'mouseenter mouseleave', '#lessons', (->
        course.show_lessons()
        return
        )

    # course click
    $('#Courses').on 'click', 'div', ->
        course.get_lessons(this.id)
        course.show_lessons()
        $('.breadcrumb').empty().append('<li id="courses"><i class="fa fa-book"></i>Courses</li><li id="lessons"><i class="fa fa-file-text-o"></i>Lessons</li>')
        return

    $('#lesson_list').on 'click', 'div', ->
        course.get_detail_lesson($(this).attr('course_id'), $(this).attr('id'))
        course.show_lesson_detail()
        return

    codeutil.initSyntax()
