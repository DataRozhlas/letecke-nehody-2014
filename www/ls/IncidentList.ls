months = <[ledna února března dubna května června července srpna září října listopadu prosince]>

class ig.IncidentList
  (@parentElement) ->
    @element = @parentElement.append \div
      ..attr \class \incident-list
    ig.utils.backbutton @element
      ..on \click ~>
        @element.classed \active no
        @parentElement.classed \push-away-barchart no
    @header = @element.append \h3
    @list = @element.append \ul

  display: (year, natureOrPhase, events) ->
    console.log events.0
    @element.classed \active yes
    @parentElement.classed \push-away-barchart year.year < 2000
    @header.html "Nehody při #{natureOrPhase.altName} v&nbsp;roce&nbsp;#{year.year}"
    @element.node!scrollTop = 0
    @list.selectAll \li .remove!
    events = events.slice!sort (a, b) -> b.fatalities - a.fatalities
    @list.selectAll \li .data events .enter!append \li
      ..append \h4
       ..html -> "#{it.opr} #{it.type}"
      ..append \span
        ..attr \class \fatalities
        ..html ->
          suff =
            | 1 < it.fatalities < 5 => "oběti"
            | 1 == it.fatalities => "oběť"
            | otherwise => "oběťí"
          "#{it.fatalities} #suff"
      ..append \span
        ..attr \class \dep-dest
          ..append \abbr
            ..attr \class \dep
            ..html -> it.dep || "???"
            ..attr \title -> it.dep_full
          ..append \span
            ..attr \class \sep
            ..html " – "
          ..append \abbr
            ..attr \class \dest
            ..html -> it.dest || "???"
            ..attr \title -> it.dest_full
      ..append \span
        ..attr \class \date
        ..html -> "#{it.date.getDate!}. #{months[it.date.getMonth!]} #{it.date.getFullYear!}"
      ..append \a
        ..attr \href -> "http://aviation-safety.net/database/record.php?id=#{it.file}"
        ..attr \target \_blank
        ..html "Podrobnosti o nehodě na aviation-safety.net"
