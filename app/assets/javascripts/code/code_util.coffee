
window.codeutil =
    getParameterByName: (name) ->
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]")
        regex = new RegExp("[\\?&]" + name + "=([^&#]*)")
        #url取得
        results = regex.exec(location.search)
        if results is null
              null
        else
              decodeURIComponent(results[1].replace(/\+/g, " "))

    syntaxHighlight: (json) ->
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

    initSyntax: ->
        lang = codeutil.getParameterByName "lang"
        #syntax_listのアイコン
        ICONS = ['+', '−', '×', '÷', '%', 'log', 'aⁿ', '&', '!&', 'ǀǀ', '!ǀǀ', '⊕', '=', '≠','>', '≥', '<', '≤','→', '↻', 'if','a', '0']
        URL = "/api/v1/abstractsyntax/"
        LANG = lang ? "en"
        $.get URL + LANG, null, (lists) =>
            abstract_syntax_lists = $("#abstract_syntax_lists")
            window.syntaxList = lists
            for l, i in lists
                line = $('<div></div>',
                    class: "ui-widget-content" + " " + l.class_name
                    id: "syntax"
                    class_name: l.class_name
                    string: l.string
                    'data-toggle': 'popover'
                    'data-trigger': 'hover'
                    title: l.name
                    'data-content': l.description).text(ICONS[i])

                # 使えるbuttonを追加
                abstract_syntax_lists.append(line)
                $('[data-toggle="popover"]').popover()
                codeui.enDraggable $('#abstract_syntax_lists div')

    executeRequest: (params) ->
        $.ajax '/api/v1/execute',
            type:'POST'
            dataType:'json'
            data : params
            timeout: 10000
            success: (data) ->
                console.log data
                #    $('#output_code').html syntaxHighlight JSON.stringify(data, undefined, 4)
                headline_text = '<table class = "table table-hover"><thead><tr><th></td><th>' + I18n.t('Excute Code') + '</th><th>' + I18n.t('Excute Result') + '</th></tr></thead><tbody></tbody></table>'
                $('#output_code').append(headline_text)
                for d, i in data
                    line_text = '<tr><th>' + (i+1).toString() + '</th><td>' + d['exec'] + '</td><td>' + d['result'] + '</td></tr>'
                    $('#output_code table tbody').append(line_text)
            error: (XMLHttpRequest, textStatus, errorThrown) ->
                alert(textStatus)
    
