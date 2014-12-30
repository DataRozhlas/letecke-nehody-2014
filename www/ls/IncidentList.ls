months = <[ledna února března dubna května června července srpna září října listopadu prosince]>

class ig.IncidentList
  (@parentElement) ->
    @element = @parentElement.append \div
      ..attr \class \incident-list
    ig.utils.backbutton @element
      ..on \click ~>
        @element.classed \active no
    @header = @element.append \h3
    @list = @element.append \ul

  display: (year, natureOrPhase, events) ->
    @element.classed \active yes
    @header.html "Nehody při #{natureOrPhase.altName} v&nbsp;roce&nbsp;#{year.year}"
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
          ..append \span
            ..attr \class \dep
            ..html -> it.dep
          ..append \span
            ..attr \class \dest
            ..html -> it.dest
      ..append \span
        ..attr \class \date
        ..html -> "#{it.date.getDate!}. #{months[it.date.getMonth!]} #{it.date.getFullYear!}"
      ..append \a
        ..attr \href -> "http://aviation-safety.net/database/record.php?id=#{it.file}"
        ..attr \target \_blank
        ..html "Podrobnosti o nehodě na aviation-safety.net"
