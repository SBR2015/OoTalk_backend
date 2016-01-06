window.course =
    get_courses: ->
        URL = '/api/v1/courses.json'
        $.get URL, null, (lists) =>
            all_lists = ''
            for l in lists
                all_lists += '<div id="' + l.id + '">' + '<i class="fa fa-book fa-5x"></i><br />' + l.title + '</div>'
            $('#course_list').empty().append(all_lists)

    get_lessons: (course_id) ->
        URL = '/api/v1/courses/' + course_id + '/lessons.json'
        $.get URL, null, (lists) =>
            all_lists = ''
            for l in lists
                all_lists += '<div id="' + l.id + '" course_id="' + l.course_id + '">' + l.title + '</div>'
            $('#lesson_list').empty().append(all_lists)

    get_detail_lesson: (course_id, lesson_id) ->
        URL = '/api/v1/courses/' + course_id + '/lessons/' + lesson_id + '.json'
        this_lesson = ''
        $.get URL, null, (lesson) =>
            this_lesson += '<div id="title"><h2>' + lesson.title + '</h2></div>'
            this_lesson += '<div id="line"></div>'
            this_lesson += '<p id="body" class="lead">' + lesson.body + '</p>'
            $('#lesson_detail').empty().append('<div id="' + lesson_id + '" course_id="' + course_id + '">' + this_lesson + '</div>')

    show_courses: ->
        $('#course_list').show()
        $('#lesson_list').hide()
        $('#lesson_detail').hide()

    show_lessons: ->
        $('#course_list').hide()
        $('#lesson_list').show()
        $('#lesson_detail').hide()

    show_lesson_detail: ->
        $('#course_list').hide()
        $('#lesson_list').hide()
        $('#lesson_detail').show()
