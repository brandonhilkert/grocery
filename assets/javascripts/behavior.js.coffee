# if navigator.userAgent.match(/iPhone/i) or navigator.userAgent.match(/iPod/i) or navigator.userAgent.match(/iPad/i)
#   $(".item").bind "touchmove", (event) ->
#     $(this).find(".actions").fadeIn('fast')
# else
$(".item").click ->
  $(this).find(".actions").toggle();

$(".item .actions button").click (event) ->
  event.stopPropagation()
  $(this).parent().toggle()
