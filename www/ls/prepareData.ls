class Nature
  (@name, @id, @color, @order, @altName) ->

natures =
  "passDomestic"      : new Nature "Vnitrostátní osobní přeprava", "passDomestic"     , \#fb9a99, 0, "vnitrostátní osobní přepravě"
  "passInternational" : new Nature "Mezinárodní osobní přeprava", "passInternational" , \#e41a1c, 1, "mezinárodní osobní přepravě"
  "exec"              : new Nature "VIP lety", "exec"                                 , \#1f78b4, 2, "VIP letech"
  "private"           : new Nature "Soukromé lety", "private"                         , \#a6cee3, 3, "soukromých letech"
  "cargo"             : new Nature "Nákladní přeprava", "cargo"                       , \#984ea3, 4, "nákladní přepravě"
  "military"          : new Nature "Armádní lety", "military"                         , \#4daf4a, 6, "armádní letech"
  "other"             : new Nature "Ostatní", "other"                                 , \#999999, 7, "letech ostatních kategorií"

ig.nature = for id, nature of natures => nature

class Phase
  (@name, @id, @color, @order, @altName) ->

phases =
  TOF: new Phase "Vzlet", \TOF                            , \#33a02c , 0, "vzletu"
  ICL: new Phase "Stoupání těsně po vzletu", \ICL         , \#b2df8a , 1, "stoupání těsně po vzletu"
  ENR: new Phase "Traťový let", \ENR                      , \#1f78b4 , 2, "traťovém letu"
  APR: new Phase "Přiblížení k letišti", \APR             , \#fb9a99 , 3, "přiblížení k letišti"
  LDG: new Phase "Přistání", \LDG                         , \#e31a1c , 4, "přistání"
  MNV: new Phase "Manévrování", \MNV                      , \#f781bf , 5, "manévrování"
  STD: new Phase "Stání (na letišti)", \STD               , \#fdbf6f , 6, "stání (na letišti)"
  TXI: new Phase "Pojíždění", \TXI                        , \#ff7f00 , 7, "pojíždění"
  PBT: new Phase "Posunování a vytlačování od gatu", \PBT , \#fed9a6 , 8, "posunování a vytlačování od gatu"
  UNK: new Phase "Neznámý", \UNK                          , \#999999 , 9, "neznámé fázi letu"

ig.phase = for id, phase of phases => phase

ig.prepareData = ->
  stats = d3.tsv.parse do
    ig.data.stats
    (row) ->
      row.nature = natures[row.nature]
      row.fatalities = parseInt row.fatalities, 10
      row.date = new Date!
        ..setTime 0
        ..setFullYear row.file.substr 0, 4
        ..setMonth (parseInt((row.file.substr 4, 2), 10) - 1)
        ..setDate row.file.substr 6, 2
      row.phase = phases[row.phase]
      row
