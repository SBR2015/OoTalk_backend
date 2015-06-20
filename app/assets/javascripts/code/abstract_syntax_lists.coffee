# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class AbstractSyntaxLists
  URL = "/api/v1/abstractsyntax/"
  LANG = "ja"
  $ ->
    $.get(URL + LANG, null, (lists) =>
      abstract_syntax_lists = $("#abstract_syntax_lists")

      for l in lists
        line = $('<div></div>',
#          id: l.id,
#          class_name: l.class_name,
          class: "abstract_syntax",
          id: l.class_name,
          draggable: true,
          string: l.string
        ).text(l.name)
        console.log(line)
        abstract_syntax_lists.append(line)
    )
