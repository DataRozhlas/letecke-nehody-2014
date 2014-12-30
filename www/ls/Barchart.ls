class Year
  (@year) ->
    @categories = []
    @categoriesAssoc = {}
    @fatalities = 0

  addEvent: (categoryId, event) ->
    if @categoriesAssoc[categoryId] is void
      @categoriesAssoc[categoryId] = new Category @
      @categories.push @categoriesAssoc[categoryId]
    @categoriesAssoc[categoryId].addEvent event
    @fatalities += event.fatalities

class Category
  (@year) ->
    @events = []
    @fatalities = 0

  addEvent: (event) ->
    @events.push event
    @fatalities += event.fatalities


class ig.Barchart
  (@parentElement, @data, @groupBy) ->
    @element = @parentElement.append \div
      ..attr \class "barchart #{@groupBy}"
    years = [1989 to 2014].map -> new Year it
    for event in @data
      categoryId = event[@groupBy].id
      yearId = event.date.getFullYear! - 1989
      years[yearId].addEvent categoryId, event
    maxYearlyFatalities = d3.max years.map (.fatalities)
    for year in years
      year.categories.sort (a, b) ~> a.events.0[@groupBy].order - b.events.0[@groupBy].order
      year.fatalitiesBuffer = maxYearlyFatalities - year.fatalities
    @yScale = d3.scale.linear!
      ..domain [0, maxYearlyFatalities]
      ..range [0 100]
    @xScale = d3.scale.linear!
      ..domain [years.0.year, years[*-1].year]
      ..range [0 100]
    @cols = @element.append \div
      ..attr \class "cols"
    @col = @cols.selectAll \div.col .data years .enter!append \div
      ..attr \class \col
      ..style \width "#{100 / years.length}%"
      ..append \div
        ..attr \class \col-content
        ..style \top ~> @yScale it.fatalities
        ..append \div .attr \class \buffer
            ..style \height ~> "#{@yScale it.fatalitiesBuffer}%"
        ..selectAll \div.category .data (.categories) .enter!append \div
          ..attr \class \category
          ..style \height ~> "#{@yScale it.fatalities}%"
          ..style \background-color ~> it.events.0.[@groupBy].color
        ..append \div
          ..attr \class \fatalities-count
            ..html ->
              ig.utils.formatNumber it.fatalities
            ..style \bottom ~> "#{@yScale it.fatalities}%"
      ..append \div
        ..attr \class \axis
        ..html -> it.year.toString!substr 2



