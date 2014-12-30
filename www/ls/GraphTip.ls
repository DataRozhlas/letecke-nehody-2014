class ig.GraphTip
  (@graph) ->
    @element = @graph.parentElement.append \div
      ..attr \class "graph-tip"
    @content = @element.append \div
      ..attr \class \content
    @arrow = @element.append \div
      ..attr \class \arrow


  display: (point, content) ->
    @element.classed \active yes
    @content.html content
    width = @element.node!offsetWidth
    height = @element.node!offsetHeight
    {left:xPosition, top: yPosition} = ig.utils.offset point
    xPosition += point.offsetWidth / 2
    left = xPosition - width / 2
    offset = 0
    if left < 0
      offset = left
      left = 0
    if left + width > window.innerWidth
      offset = left + width - window.innerWidth
      left = window.innerWidth - width
    top = yPosition - height
    @element
      ..style \left left + "px"
      ..style \top top + "px"
    @arrow.style \left offset + "px"

  hide: ->
    @element.classed \active no
