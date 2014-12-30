class Nature
  (@name, @id) ->
natures =
  "passDomestic"      : new Nature "Vnitrostátní osobní přeprava", "passDomestic"
  "passInternational" : new Nature "Mezinárodní osobní přeprava", "passInternational"
  "exec"              : new Nature "VIP lety", "exec"
  "private"           : new Nature "Soukromé lety", "private"
  "other"             : new Nature "Ostatní", "other"
  "military"          : new Nature "Armádní lety", "military"
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
  console.log stats.0
