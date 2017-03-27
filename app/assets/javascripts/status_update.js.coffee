$ = jQuery

$.fn.extend
  status_update: () ->
    table = new AutoStatusTable($(this))
    setInterval(table.updateAll, 3000)

class @AutoStatusTable
  constructor: (@element) ->

  updateAll: => 
    $.each($(@element).find('a'), (index, link) ->
      block = $(link).parent("p")

      $.getJSON $('span.status', block).data("url"), (data) -> 
        if !$("a", block).data("currentUser")
          $("a.name", block).text(data["full_name"])

        classToAdd = "status-#{ data["status"] }"
        $("span.status", block).removeClass("status-in status-out").addClass(classToAdd).text(data["status"])
      )
