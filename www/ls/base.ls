init = ->
  data = ig.prepareData!
  container = d3.select ig.containers.base
  hash = window.location.hash.substr 1
  if hash == "phase"
    container.append \h1
      ..html "Návrat nehod v traťovém letu"
    container.append \h2
      ..html "Poslední roky se většina nehod odehrávala ve fázi přiblížení a přistání na letišti. Letos hrály nejvýznamnější roli nehody během letu."
    incidentList = new ig.IncidentList container
    barchart = new ig.Barchart container, data, \phase, incidentList
  else
    container.append \h1
      ..html "Nejvíce úmrtí si obvykle připisují vnitrostátní linky"
    container.append \h2
      ..html "Rok 2014 však byl výjimkou, většina obětí leteckých nehod letěla mezinárodně."

    incidentList = new ig.IncidentList container
    barchart = new ig.Barchart container, data, \nature, incidentList
  container.append \p .html "Po najetí myši nad graf se vám zobrazí podrobnosti o daném roce"
  container.append \span
    ..attr \class \attrib
    ..html "Data &copy; <a target='_blank' href='http://aviation-safety.net'>Aviation-safety.net</a>"



if d3?
  init!
else
  $ window .bind \load ->
    if d3?
      init!
