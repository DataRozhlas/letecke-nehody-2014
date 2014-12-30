init = ->
  data = ig.prepareData!
  container = d3.select ig.containers.base
  container.append \h1
    ..html "Nejvíce úmrtí si obvykle připisují vnitrostátní linky"
  container.append \h2
    ..html "Rok 2014 však byl výjimkou, většina obětí leteckých nehod letěla mezinárodně."

  incidentList = new ig.IncidentList container
  barchart = new ig.Barchart container, data, \nature, incidentList



if d3?
  init!
else
  $ window .bind \load ->
    if d3?
      init!
