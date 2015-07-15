$ ->
  myCodeMirror = CodeMirror.fromTextArea $("#json_code")[0],
    mode:
      name:"javascript"
      json:true
    lineNumbers: true
    tabSize: 2

  $('#code_execute').submit (event) ->
    event.preventDefault()

    doc = myCodeMirror.getDoc()
    console.log doc.getValue()

    $('#output_code').text ""
    o = {}
    # a = $(this).serializeArray()
    o["code[src]"] = doc.getValue()
    # $.each a, () ->
    #   if o[this.name] != undefined
    #     if !o[this.name].push
    #       o[this.name] = [o[this.name]]
    #
    #     o[this.name].push this.value || ''
    #   else
    #     o[this.name] = this.value || ''

    $.ajax '/api/v1/execute',
      type:'POST'
      dataType:'json'
      data : o
      timeout: 10000
      success: (data) ->
        $('#output_code').text JSON.stringify(data)
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        alert(textStatus);
