$ ->
  syntaxHighlight = (json) ->
    json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    return json.replace /("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, (match) ->
      cls = 'number'
      if /^"/.test(match)
        if /:$/.test(match)
          cls = 'key'
        else
          cls = 'string'
      else if /true|false/.test(match)
        cls = 'boolean'
      else if /null/.test(match)
        cls = 'null'
      return '<span class="' + cls + '">' + match + '</span>'


  if $("#json_code").length == 1
    myCodeMirror = CodeMirror.fromTextArea $("#json_code")[0],
      mode:
        name:"javascript"
        json:true
      lineNumbers: true
      tabSize: 2

  $('#code_execute').submit (event) ->
    event.preventDefault()

    doc = myCodeMirror.getDoc()
    $('#output_code').text ""
    o = {}
    o["code[src]"] = doc.getValue()
    $.ajax '/api/v1/execute',
      type:'POST'
      dataType:'json'
      data : o
      timeout: 10000
      success: (data) ->
        $('#output_code').html syntaxHighlight JSON.stringify(data, undefined, 4)
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        alert(textStatus);

  $('#ast_code_execute').submit (event) ->
    event.preventDefault()

    $('#output_code').text ""
    o = {}
    o["code[src]"] = ""
    $.ajax '/api/v1/execute',
      type:'POST'
      dataType:'json'
      data : o
      timeout: 10000
      success: (data) ->
        $('#output_code').html syntaxHighlight JSON.stringify(data, undefined, 4)
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        alert(textStatus);

  return
