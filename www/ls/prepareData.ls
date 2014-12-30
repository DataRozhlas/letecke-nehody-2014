class Nature
  (@name, @id, @color, @order) ->

natures =
  "passDomestic"      : new Nature "Vnitrostátní osobní přeprava", "passDomestic"     , \#fb9a99, 0
  "passInternational" : new Nature "Mezinárodní osobní přeprava", "passInternational" , \#e41a1c, 1
  "exec"              : new Nature "VIP lety", "exec"                                 , \#1f78b4, 2
  "private"           : new Nature "Soukromé lety", "private"                         , \#a6cee3, 3
  "cargo"             : new Nature "Nákladní přeprava", "cargo"                       , \#984ea3, 4
  "ferry"             : new Nature "Přelet letounu", "ferry"                          , \#a65628, 5
  "military"          : new Nature "Armádní lety", "military"                         , \#4daf4a, 6
  "other"             : new Nature "Ostatní", "other"                                 , \#999999, 7

ig.natures = for id, nature of natures => nature

class Phase
  (@name, @id) ->

phases =
  APR: new Phase "Přiblížení k letišti", \APR
  ENR: new Phase "Traťový let", \ENR
  MNV: new Phase "Manévrování", \MNV
  ICL: new Phase "Stoupání těsně po vzletu", \ICL
  TOF: new Phase "Vzlet", \TOF
  STD: new Phase "Stání (na letišti)", \STD
  UNK: new Phase "Neznámý", \UNK
  LDG: new Phase "Přistání", \LDG
  TXI: new Phase "Pojíždění", \TXI
  PBT: new Phase "Posunování a vytahování od gatu", \PBT

ig.phases = for id, phase of phases => phase

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
