init = ->
  data = ig.prepareData!
  container = d3.select ig.containers.base
  container.append \h1
    ..html "Nejvíce úmrtí si obvykle připisují vnitrostátní linky"
  container.append \h2
    ..html "Rok 2014 však byl výjimkou, většina obětí leteckých nehod letěla mezinárodně."
  new ig.Barchart container, data, \nature


if d3?
  init!
else
  $ window .bind \load ->
    if d3?
      init!
