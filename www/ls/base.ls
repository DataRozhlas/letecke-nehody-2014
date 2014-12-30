init = ->
  data = ig.prepareData!
if d3?
  init!
else
  $ window .bind \load ->
    if d3?
      init!
